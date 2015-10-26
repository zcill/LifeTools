//
//  ZCCustomNavigation.m
//  生活百事通
//
//  Created by 朱立焜 on 15/10/21.
//  Copyright © 2015年 zcill. All rights reserved.
//

#import "ZCCustomNavigation.h"
#import "ZCHeader.h"
#import "ZCCitiesTableViewController.h"

@interface ZCCustomNavigation ()<ZCCitiesTableViewControllerDelegate>

@end

@implementation ZCCustomNavigation

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigation];
}

- (void)initNavigation {
    
    // 隐藏系统navigationBar
    self.navigationBar.hidden = YES;
    
    UIView *naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    naviView.backgroundColor = [UIColor flatWhiteColor];
    
    // 设置titleLabel
    CGFloat labelX = ScreenWidth / 3;
    CGFloat labelY = CGRectGetHeight(naviView.frame) / 2 - 5;
    CGFloat labelW = ScreenWidth / 3;
    CGFloat labelH = CGRectGetHeight(naviView.frame) / 2;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
    titleLabel.text = @"生活";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [naviView addSubview:titleLabel];
    
    // 设置定位按钮
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat buttonX = ScreenWidth - (5+49);
    CGFloat buttonY = labelY;
    CGFloat buttonW = 49.f;
    CGFloat buttonH = labelH;
    leftButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    [leftButton setImage:[UIImage imageNamed:@"navigation_locationicon"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(selectCity) forControlEvents:UIControlEventTouchUpInside];
    
    [naviView addSubview:leftButton];
    
    [self.view addSubview:naviView];
}

// 选择城市
- (void)selectCity {
    
    ZCCitiesTableViewController *cities = [[ZCCitiesTableViewController alloc] initWithStyle:UITableViewStylePlain];
    cities.delegate = self;
    
    [self pushViewController:cities animated:YES];
    
}

#pragma mark >>>>>>>> ZCCitiesTableViewController代理方法 >>>>>>>>
- (void)didSelectCity:(NSString *)city {
    
    
    
}


@end
