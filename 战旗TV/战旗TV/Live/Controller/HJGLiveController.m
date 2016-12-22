//
//  HJGLiveController.m
//  战旗TV
//
//  Created by 黄建国 on 2016/9/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HJGLiveController.h"
#import "HJGHomeCell.h"
#import "HJGCollectionCellModel.h"
#import "HJGVideoPlayController.h"

#define IDENTIFIER_CELL @"homeMenuCell"
@interface HJGLiveController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//collection
@property (nonatomic, strong) UICollectionView *collection;

@property (nonatomic, strong) NSMutableArray *liveListData;

@property (nonatomic, assign) int page;

@end

@implementation HJGLiveController

- (NSMutableArray *)liveListData{
    if (!_liveListData) {
        _liveListData = [NSMutableArray array];
    }
    return _liveListData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    [self firstLoad];
    [self getLiveListData];
    [self refresh];
}

- (void)firstLoad{
    //collection
    self.page = 1;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(H(10),W(10),H(10),W(10));
    self.collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kMarginTopHeight, WIDTH, HEIGHT - kMarginTopHeight - kTabBarHeight) collectionViewLayout:layout];
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
        self.page = 1;
        [self.liveListData removeAllObjects];
        [self getLiveListData];
    }];
    
    self.collection.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page = self.page + 1;
        [self getLiveListData];
    }];
}

#pragma mark - collectionDelegate and dataSourse
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.liveListData.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((WIDTH - W(40))/2.0, H(130));
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HJGHomeCell *cell = (HJGHomeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:IDENTIFIER_CELL forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.model = (HJGCollectionCellModel *)[self.liveListData objectAtIndex:indexPath.row];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(H(10), W(10), H(10), W(10));
}

- (void)getLiveListData{
    HJGNetworkManger *manger = [[HJGNetworkManger alloc]init];
    [manger getLiveListDataSuccessBlock:^(int code, NSDictionary *responDic) {
        NSArray *arr = responDic[@"data"][@"rooms"];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HJGCollectionCellModel *model = [HJGCollectionCellModel mj_objectWithKeyValues:(NSDictionary *)obj];
            [self.liveListData addObject:model];
        }];
        [self.collection reloadData];
    } failureBlock:^(NSError *error){
        NSLog(@"获取数据失败");
    } page:[NSString stringWithFormat:@"%d",self.page]
     ];
    
    [self.collection.mj_header endRefreshing];
    [self.collection.mj_footer endRefreshing];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HJGVideoPlayController *videoVC = [[HJGVideoPlayController alloc]init];
    videoVC.videoID = ((HJGCollectionCellModel *)self.liveListData[indexPath.row]).videoId;
    [self.navigationController pushViewController:videoVC animated:YES];
}
@end
