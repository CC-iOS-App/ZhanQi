//
//  HJGHomePageController.m
//  战旗TV
//
//  Created by 黄建国 on 2016/9/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HJGHomePageController.h"
#import "HJGHomeCycleView.h"
#import "HJGHomeCell.h"
#import "HJGCollectionCellModel.h"
#import "HJGHomeSectionModel.h"
#import "HJGCycleModel.h"
#import "HJGCycleListModel.h"
#import "HJGMenueHeader.h"
#import "HJGVideoPlayController.h"

#define IDENTIFIER_CELL @"homeMenuCell"
#define IDENTIFIER_HEADER @"homeMenuHeader"
#define IDENTIFIER_HEADERSECTION @"homeMenuHeaderSection"

@interface HJGHomePageController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
//轮播器
@property (nonatomic, strong) HJGHomeCycleView *homeCycleView;
//collection
@property (nonatomic, strong) UICollectionView *collection;
//懒加载
@property (nonatomic, strong) NSMutableArray *sectionData;
//懒加载主播cell数据
@property (nonatomic, strong) NSMutableArray *avatarData;

@property (nonatomic, strong) NSMutableArray *banderListData;

@property (nonatomic, strong) NSMutableArray *banderData;

@property (nonatomic, strong) NSMutableArray *sectionTitleData;

@end

@implementation HJGHomePageController

- (NSMutableArray *)sectionTitleData{
    if (!_sectionTitleData) {
        _sectionTitleData = [NSMutableArray array];
    }
    return _sectionTitleData;
}

- (NSMutableArray *)banderData{
    if (!_banderData) {
        _banderData = [NSMutableArray array];
    }
    return _banderData;
}

- (NSMutableArray *)banderListData{
    if (!_banderListData) {
        _banderListData = [NSMutableArray array];
    }
    return _banderListData;
}

- (NSMutableArray *)sectionData{
    if (!_sectionData) {
        _sectionData = [NSMutableArray array];
    }
    return _sectionData;
}

- (NSMutableArray *)avatarData{
    if (!_avatarData) {
        _avatarData = [NSMutableArray array];
    }
    return _avatarData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self firstLoading];
    //获取网络数据
    [self getBanderData];
    [self getAnchorListData];
}

- (void)firstLoading{
    //collection
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
    [self.collection registerClass:[HJGMenueHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:IDENTIFIER_HEADERSECTION];
    [self.collection registerClass:[HJGHomeCycleView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:IDENTIFIER_HEADER];
    
    [self.view addSubview:self.collection];
}

#pragma mark - collectionDelegate and dataSourse

#pragma  mark - 返回header的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(WIDTH, H(180) + 33);
    }else{
        return CGSizeMake(WIDTH, H(40));
    }
}

#pragma mark - 组头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            HJGHomeCycleView *cycleView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:IDENTIFIER_HEADER forIndexPath:indexPath];
            cycleView.photoData = self.banderListData.copy;
            cycleView.titleData = ((HJGHomeSectionModel *)self.sectionTitleData[indexPath.section]).title;
            reusableview = cycleView;
        }else{
            HJGMenueHeader *sectionHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:IDENTIFIER_HEADERSECTION forIndexPath:indexPath];
            sectionHeader.titleData = ((HJGHomeSectionModel *)self.sectionTitleData[indexPath.section]).title;
            reusableview = sectionHeader;
        }
    }
    return reusableview;

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.sectionData.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return ((NSArray *)[self.sectionData objectAtIndex:section]).count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((WIDTH - W(40))/2.0, H(130));
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HJGHomeCell *cell = (HJGHomeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:IDENTIFIER_CELL forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.model = (HJGCollectionCellModel *)[[self.sectionData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(H(10), W(10), H(10), W(10));
}

#pragma mark - 发送网络请求，获取主播列表数据
- (void)getAnchorListData{
    HJGNetworkManger *manger = [[HJGNetworkManger alloc]init];
    [manger getHomeListDataSuccessBlock:^(int code, NSDictionary *responDic) {
        NSArray *arr = responDic[@"data"];
        for (NSDictionary *dic in arr) {
            HJGHomeSectionModel *sectionModel = [HJGHomeSectionModel mj_objectWithKeyValues:dic];
            //外围标题模型
            [self.sectionTitleData addObject:sectionModel];
            [self.avatarData removeAllObjects];
            for (HJGCollectionCellModel *cellModel in sectionModel.lists) {
                //单个item模型
                [self.avatarData addObject:cellModel];
            }
            //每个组模型
            [self.sectionData addObject:self.avatarData.copy];
        }
        [self.collection reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"获取失败");
    }];

}


#pragma  mark - 获取首页bander数据
- (void)getBanderData{
    HJGNetworkManger *manger = [[HJGNetworkManger alloc]init];
    [manger getHomeBanderDataSuccessBlock:^(int code, NSDictionary *responDic) {
        NSArray *arr = responDic[@"data"];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HJGCycleListModel *listModel = [HJGCycleListModel mj_objectWithKeyValues:(NSDictionary *)obj];
            HJGCycleModel *model = [HJGCycleModel mj_objectWithKeyValues:(NSDictionary *)listModel.room];
            [self.banderData addObject:model];
            [self.banderListData addObject:listModel];
        }];
        [self.collection reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"获取数据失败");
    }];

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HJGVideoPlayController *videoVC = [[HJGVideoPlayController alloc]init];
    videoVC.videoID = ((HJGCollectionCellModel *)[[self.sectionData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]).videoId;
    [self.navigationController pushViewController:videoVC animated:YES];

}

@end
