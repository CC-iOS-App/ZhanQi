//
//  HJGGameController.m
//  战旗TV
//
//  Created by 黄建国 on 2016/9/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HJGGameController.h"
#import "HJGGameCell.h"
#import "HJGGameCellModel.h"

#define IDENTIFIER_GAMECELL @"gameCell"
@interface HJGGameController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collection;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray *gameListData;

@end

@implementation HJGGameController

- (NSMutableArray *)gameListData{
    if (!_gameListData) {
        _gameListData = [NSMutableArray array];
    }
    return _gameListData;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [self firstLoad];
    self.page = 1;
    [self getGameData:self.page];
    [self gameRefresh];
}

- (void)gameRefresh{
    //下拉刷新
    self.collection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.gameListData removeAllObjects];
        self.page = 1;
        [self getGameData:self.page];
    }];
    //上拉刷新
    self.collection.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page = self.page + 1;
        [self getGameData:self.page];
    }];
}

- (void)firstLoad{
    //collection
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(H(6),W(6),H(6),W(6));
    self.collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kMarginTopHeight, WIDTH, HEIGHT - kMarginTopHeight - kTabBarHeight) collectionViewLayout:layout];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    self.collection.backgroundColor = [UIColor whiteColor];
    self.collection.showsVerticalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.collection registerClass:[HJGGameCell class] forCellWithReuseIdentifier:IDENTIFIER_GAMECELL];
    [self.view addSubview:self.collection];

}

#pragma mark - collectionDelegate and dataSourse
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.gameListData.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((WIDTH - W(40))/3.0, H(153));
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HJGGameCell *cell = (HJGGameCell *)[collectionView dequeueReusableCellWithReuseIdentifier:IDENTIFIER_GAMECELL forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.model = (HJGGameCellModel *)self.gameListData[indexPath.row];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(H(15), W(6), H(6), W(6));
}

- (void)getGameData:(NSInteger)page{
    NSString *str = [NSString stringWithFormat:@"%ld.json",page];
    HJGNetworkManger *manger = [[HJGNetworkManger alloc]init];
    [manger getGameData:str SuccessBlock:^(int code, NSDictionary *responDic) {
        NSArray *arr = responDic[@"data"][@"games"];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HJGGameCellModel *model = [HJGGameCellModel mj_objectWithKeyValues:(NSDictionary *)obj];
            [self.gameListData addObject:model];
        }];
        [self.collection reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"获取数据失败");
    }];
    [self.collection.mj_header endRefreshing];
    [self.collection.mj_footer endRefreshing];
    [self.collection reloadData];

}

@end
