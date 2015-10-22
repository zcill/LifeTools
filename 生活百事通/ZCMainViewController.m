//
//  ZCMainViewController.m
//  生活百事通
//
//  Created by 朱立焜 on 15/10/22.
//  Copyright © 2015年 zcill. All rights reserved.
//

#import "ZCMainViewController.h"

@interface ZCMainViewController ()<UITableViewDataSource, UITableViewDelegate>

// tableView相关
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;


@end

@implementation ZCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)initTableView {

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
}


#pragma mark ----------- tableView DataSource数据源协议方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseID = @"MainCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

@end
