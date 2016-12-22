//
//  HJGGameListController.m
//  战旗TV
//
//  Created by 黄建国 on 2016/12/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HJGGameListController.h"
#import "HJGHomeCell.h"
#import "HJGVideoPlayController.h"
#import "HJGCollectionCellModel.h"

#define IDENTIFIER_CELL @"gameListCell"
@interface HJGGameListController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//collection
@property (nonatomic, strong) UICollectionView *collection;

@property (nonatomic, strong) NSMutableArray *gameListData;

@property (nonatomic, assign) int pageStr;

@end

@implementation HJGGameListController

- (NSMutableArray *)gameListData{
    if (!_gameListData) {
        _gameListData = [NSMutableArray array];
    }
    return _gameListData;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    [self firstLoad];
    [self getGameListData:self.gameID];
    [self refresh];
}

- (void)firstLoad{
    //collection
    self.pageStr = 1;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(H(10),W(10),H(10),W(10));
    self.collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kMarginTopHeight, WIDTH, HEIGHT - kMarginTopHeight) collectionViewLayout:layout];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    self.collection.backgroundColor = [UIColor whiteColor];
    self.collection.showsVerticalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.collection registerClass:[HJGHomeCell class] forCellWithReuseIdentifier:IDENTIFIER_CELL];
    [self.view addSubview:self.collection];
}


#pragma mark - 上拉刷新 下拉刷新
- (void)refresh{
    
    self.collection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageStr = 1;
        [self.gameListData removeAllObjects];
        [self getGameListData:self.gameID];
    }];
    
    self.collection.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageStr = self.pageStr + 1;
        [self getGameListData:self.gameID];
    }];
}

#pragma mark - collectionDelegate and dataSourse
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.gameListData.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((WIDTH - W(40))/2.0, H(130));
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HJGHomeCell *cell = (HJGHomeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:IDENTIFIER_CELL forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.model = (HJGCollectionCellModel *)[self.gameListData objectAtIndex:indexPath.row];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(H(10), W(10), H(10), W(10));
}



- (void)getGameListData:(NSString *)gameID{
    HJGNetworkManger *manger = [[HJGNetworkManger alloc]init];
    [manger getGameListData:[NSString stringWithFormat:@"%d",self.pageStr] SuccessBlock:^(int code, NSDictionary *responDic) {
        NSArray *arr = responDic[@"data"][@"rooms"];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HJGCollectionCellModel *model = [HJGCollectionCellModel mj_objectWithKeyValues:(NSDictionary *)obj];
            [self.gameListData addObject:model];
        }];
        [self.collection reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"获取数据失败");
    } gameID:self.gameID];
    [self.collection.mj_header endRefreshing];
    [self.collection.mj_footer endRefreshing];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HJGVideoPlayController *videoVC = [[HJGVideoPlayController alloc]init];
    videoVC.videoID = ((HJGCollectionCellModel *)self.gameListData[indexPath.row]).videoId;
    [self.navigationController pushViewController:videoVC animated:YES];
}

@end
