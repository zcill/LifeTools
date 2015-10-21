//
//  ZCCustomTabBar.m
//  生活百事通
//
//  Created by 朱立焜 on 15/10/21.
//  Copyright © 2015年 zcill. All rights reserved.
//

#import "ZCCustomTabBar.h"
#import "ZCHeader.h"
#import "ZCQuickCreate.h"

@interface ZCCustomTabBar ()

@end

@implementation ZCCustomTabBar

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customTabBar];
}

#pragma mark - 定制TabBar

- (void)customTabBar{
    //隐藏官方tabBar
    self.tabBar.hidden = YES;
    
    /*自定义的tabBar由ImageView+buttons组成*/
    //创建一个图片视图
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, ScreenHeight - TabBarHeight, ScreenWidth, TabBarHeight)];
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.layer.borderColor = [UIColor flatWhiteColor].CGColor;
    imageView.layer.borderWidth = 0.3;
    
    //建立数组模型
    self.imageNames = @[@"mainNormal", @"goodsNormal", @"dingyueItemNormal", @"personNormal"];
    self.selectedImageNames = @[@"mainSelected", @"goodsSelected", @"dingyueItemSelected", @"personSelected"];
    self.titles = @[@"生活", @"团购", @"工具", @"我的"];
    self.buttons = [[NSMutableArray alloc]initWithCapacity:0];
    //创建button
    for (NSInteger i = 0; i < 4; i++) {
        
        // 使用类扩展快速创建button和设置button
        UIButton *button = [UIButton initButtonWithTitle:self.titles[i] ImageName:self.imageNames[i] selectedImageName:self.selectedImageNames[i] tag:i + 10 adjustImageWhenHighlighted:NO];
        [button zc_setButtonTitleNormalColor:[UIColor grayColor] titleSelectedColor:RGBA(244, 59, 51, 1) titleFont:[UIFont systemFontOfSize:12] titleEdgeInsets:UIEdgeInsetsMake(0, -35, -30, 0) imageEdgeInsets:UIEdgeInsetsMake(-15, 0, 0, -13)];
        
        // 设置frame
        CGFloat itemLength = ScreenWidth / 4;
        NSLog(@"itemLength:%f",itemLength);
        
        button.frame = CGRectMake(itemLength * i, 0, itemLength, TabBarHeight);
        
        //添加事件
        [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // 设置默认选中第一个按钮
        button.selected = i==0;
        
        [imageView addSubview:button];
        [self.buttons addObject:button];
        
    }
    //设置imageView可以接受事件
    imageView.userInteractionEnabled = YES;
    
    [self.view addSubview:imageView];
    
}

- (void)onClick:(UIButton *)button
{
    //被点中，进入选中状态
    button.selected = YES;
    //不能接收事件
    button.userInteractionEnabled = NO;
    
    //切换页面 使用继承自父类的方法
    self.selectedIndex = button.tag - 10;
    
    //点击了一个页面，别的页面button全灭
    for (NSInteger i = 0; i < 4; i++) {
        //        UIButton *bt = (id)[self.view viewWithTag:10 + i];
        UIButton *bt = self.buttons[i];
        //viewWithTag这个方法是深度遍历，也就是说，不仅能找到self.view的子视图，也能找到子视图的子视图
        if (i == button.tag - 10) {
            //break是结束整个循环体，continue是结束单次循环
            continue;
        }
        bt.selected = NO;
        bt.userInteractionEnabled = YES;
    }
}


@end
