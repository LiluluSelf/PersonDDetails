//
//  PersonViewController.m
//  PersonalDetails
//
//  Created by hanvon on 16/8/30.
//  Copyright © 2016年 hanvon. All rights reserved.
//

#import "PersonViewController.h"
#import "UIImage+image.h"
//头部的高度
#define LHeaderH 200
//tabBar的高度
#define LTarBarH 44
/** tableview 原始偏移量 */
#define LOriOffsetY -244


@interface PersonViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tableView */
@property (nonatomic, strong) UITableView *tableView;

/** 头部高度约束 */
@property (weak, nonatomic)  NSLayoutConstraint *headerHeightConts;
/** 标题 */
@property(nonatomic, strong)UILabel *titleL;
/** 头部view */
@property (nonatomic, strong) UIView *headerV ;
@end

@implementation PersonViewController
NSString *ID =@"123";
- (void)viewDidLoad {
    [super viewDidLoad];
    

    //tableView
    self.tableView = [[UITableView alloc]init];
    
    [self.view addSubview:self.tableView];
   
    //tableview约束
    NSLayoutConstraint *LeadingLayConT = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    [self.view addConstraint:LeadingLayConT];
    NSLayoutConstraint *TrailingLayConT = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    [self.view addConstraint:TrailingLayConT];
    
    NSLayoutConstraint *topLayConT = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    [self.view addConstraint:topLayConT];
    NSLayoutConstraint *bottomLayConT = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomLayoutGuide attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    [self.view addConstraint:bottomLayConT];
    /** tableView 只要设置额外滚动区域，就会把内容往下面挤 */
    self.tableView.contentInset = UIEdgeInsetsMake(LHeaderH + LTarBarH, 0, 0, 0);
      self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
   
    
    /** 不调整scrollView的contentInsets */
    self.automaticallyAdjustsScrollViewInsets = NO;
    /** 设置导航条navigationBar透明度为0,达到隐藏效果;必须要传默认UIBarMetricsDefault模式.*/
    self.navigationController.navigationBar.alpha = 0;
    /** 传入一张空的图片,发现有一根线,这根线其实是导航条的一个阴影.直接把它清空就行了 */
    [self.navigationController.navigationBar
     setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    
    /** 设置标题 */
    UILabel *titleL = [[UILabel alloc]init];
    titleL.text = @"个人详情页";
    [titleL sizeToFit];
    titleL.textColor = [UIColor colorWithWhite:0 alpha:0];
    self.titleL = titleL;
    self.navigationItem.titleView = self.titleL;
    
    
    self.headerV = [[UIView alloc] init];
    self.headerV.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.headerV];
    //添加headerV约束
    NSLayoutConstraint *leftLayConH = [NSLayoutConstraint constraintWithItem:self.headerV attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    [self.view addConstraint:leftLayConH];
    NSLayoutConstraint *rightLayConH = [NSLayoutConstraint constraintWithItem:self.headerV attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    [self.view addConstraint:rightLayConH];
    NSLayoutConstraint *heightLayConH = [NSLayoutConstraint constraintWithItem:self.headerV attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:200];
    [self.view addConstraint:heightLayConH];
    self.headerHeightConts = heightLayConH;
        NSLayoutConstraint *topLayConH = [NSLayoutConstraint constraintWithItem:self.headerV attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        [self.view addConstraint:topLayConH];
    
    self.headerV.translatesAutoresizingMaskIntoConstraints = NO;

    
    UIView *blueView = [[UIView alloc]init];
    blueView.translatesAutoresizingMaskIntoConstraints = NO;
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    NSLayoutConstraint *TrailingLayConB = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    [self.view addConstraint:TrailingLayConB];
    NSLayoutConstraint *LeadingLayConB = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    [self.view addConstraint:LeadingLayConB];
    NSLayoutConstraint *heightLayConB = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:44];
    [self.view addConstraint:heightLayConB];
    
    NSLayoutConstraint *TopLayConB = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headerV attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self.view addConstraint:TopLayConB];
    
    [self.view layoutIfNeeded];
    NSLog(@"tableVIew frame %@",NSStringFromCGRect(self.tableView.frame));
}
#pragma mark - tableView
/** tableview 滚动调用方法，计算它的偏移量 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y - LOriOffsetY;
    CGFloat heitht = LHeaderH - offsetY;
    if (heitht < 64) {
        heitht = 64;
    }
    
    
    CGFloat alpha = 1 * offsetY / 136.0;
    if (alpha >= 1) {
        alpha = 0.99;
    }
    
    self.titleL.textColor = [UIColor colorWithWhite:0 alpha:alpha];
    
    UIImage *image  = [UIImage imageWithColor:[UIColor colorWithWhite:1 alpha:alpha]];
    
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
   
    

    self.headerHeightConts.constant = heitht;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.textLabel.text = @"哈哈";
    return cell;
    
}


@end
