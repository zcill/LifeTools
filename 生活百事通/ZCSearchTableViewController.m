//
//  ZCSearchTableViewController.m
//  生活百事通
//
//  Created by 朱立焜 on 15/10/30.
//  Copyright © 2015年 zcill. All rights reserved.
//

#import "ZCSearchTableViewController.h"

@interface ZCSearchTableViewController ()

@property (nonatomic, strong) NSMutableArray *resultCities;

@end

@implementation ZCSearchTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _resultCities = [NSMutableArray array];
    
}

- (void)setSearchText:(NSString *)searchText {
    
    // 清除之前的搜索结果
    [self.resultCities removeAllObjects];
    
    // 筛选城市
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
