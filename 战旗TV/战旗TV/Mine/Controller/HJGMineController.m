//
//  HJGMineController.m
//  战旗TV
//
//  Created by 黄建国 on 2016/9/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HJGMineController.h"
#define KICONSIZE 70
#define KVIEWHEIGHT 30

@interface HJGMineController ()<UITableViewDelegate,UITableViewDataSource>
// 图片下面的 tableView
@property (strong, nonatomic) UITableView *tableView;
// 顶部的照片
@property (strong, nonatomic) UIImageView *topImageView;
// 毛玻璃
@property (strong, nonatomic) UIVisualEffectView *effectView;

@property (nonatomic, assign) CGFloat imageHeight;

@property (nonatomic, strong) NSMutableArray *sectionArr;

@end

@implementation HJGMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    self.title = @"我的";
    [self firstLoad];
}

#pragma mark - firstLoad
- (void)firstLoad{
    self.sectionArr = [NSMutableArray arrayWithObjects:@[@"我要直播"],@[@"每日任务",@"观看历史"],@[@"私信",@"官方公告"],@[@"设置"], nil];
    self.imageHeight = 230;
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    // 这里为了留出放照片的位置
    self.tableView.contentInset = UIEdgeInsetsMake(self.imageHeight, 0, 0, 0);
    [self.view addSubview:_tableView];

    
    
    self.topImageView = [[UIImageView alloc] initWithFrame:(CGRectMake(0, -self.imageHeight, self.view.frame.size.width, self.imageHeight))];
    _topImageView.image = [UIImage imageNamed:@"minebg"];
    _topImageView.contentMode = UIViewContentModeScaleAspectFill;
    _topImageView.clipsToBounds = YES;
    [self.tableView addSubview:self.topImageView];
    
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:(UIBlurEffectStyleLight)];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectView.frame = _topImageView.frame;
    _effectView = effectView;
    [self.tableView addSubview:_effectView];
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0,  self.imageHeight/2.0 - KVIEWHEIGHT - KICONSIZE/2.0 - 116, WIDTH, 100)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.tableView addSubview:whiteView];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, H(40), WIDTH, H(15))];
    lab.text = @"未登录";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:W(15)];
    [whiteView addSubview:lab];
    
    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake((WIDTH - KICONSIZE)/2.0, self.imageHeight/2.0 - KVIEWHEIGHT - KICONSIZE/2.0 - 150, KICONSIZE, KICONSIZE)];
    iconView.image = [UIImage imageNamed:@"AppIcon60x60"];
    iconView.layer.cornerRadius = KICONSIZE/2.0;
    iconView.layer.masksToBounds = YES;
    [self.tableView addSubview:iconView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((NSArray *)self.sectionArr[section]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"CELLID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
//    cell.textLabel.text = [NSString stringWithFormat:@"这是第%ld行",indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"ic_mail"]; 
    cell.textLabel.text = ((NSArray *)self.sectionArr[indexPath.section])[indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 向下的话 为负数
    CGFloat off_y = scrollView.contentOffset.y;
    CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
    // 下拉超过照片的高度的时候
    if (off_y < - self.imageHeight)
    {
        CGRect frame = self.topImageView.frame;
        // 这里的思路就是改变 顶部的照片的 fram
        self.topImageView.frame = CGRectMake(0, off_y, frame.size.width, -off_y);
        self.effectView.frame = self.topImageView.frame;
        // 对应调整毛玻璃的效果
        self.effectView.alpha = 1 + (off_y + self.imageHeight) / kHeight ;
    }   
}

@end
