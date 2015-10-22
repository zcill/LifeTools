//
//  ZCMainCollectionViewController.m
//  生活百事通
//
//  Created by 朱立焜 on 15/10/22.
//  Copyright © 2015年 zcill. All rights reserved.
//

#import "ZCMainCollectionViewController.h"
#import "ZCWeatherCell.h"
#import "ZCSectionModel.h"
#import "ZCItemModel.h"
#import "ZCRootViewController.h"
#import "ZCItemCell.h"
#import "ZCHeaderViewCell.h"
#import "CSStickyHeaderFlowLayout.h"
#import "ZCHeader.h"

@interface ZCMainCollectionViewController ()

@property (nonatomic, strong) NSMutableArray *sections;
@property (nonatomic, weak) ZCWeatherCell *weatherCell;

@end

@implementation ZCMainCollectionViewController

static NSString * const reuseIdentifier = @"ZCItemCell";

- (NSMutableArray *)sections {
    if (_sections == nil) {
        _sections = [NSMutableArray array];
    }
    return _sections;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册cell
    [self registerCells];
    
    self.collectionView.backgroundColor = RGBA(231, 231, 231, 1);
    
#warning 未完成天气headerView
    
    // 添加分组
    [self addSectionSearch];
    [self addSectionCalculate];
    [self addSectionTicket];
    

    
}



- (void)registerCells {
    
    // 注册单个按钮cell
    [self.collectionView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    // 注册headerCell
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZCHeaderViewCell" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ZCHeaderViewCell"];
    
    // 注册weatherCell，使用第三方，保证可以悬停
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZCWeatherCell" bundle:nil] forSupplementaryViewOfKind:CSStickyHeaderParallaxHeader withReuseIdentifier:@"ZCWeatherCell"];
    
}

- (void)addSectionSearch {
    
    // 添加ItemSection
    ZCSectionModel *section = [ZCSectionModel defaultSection];
    section.headerTitle = @"生活查询";
    
#warning item的viewController未设置
    // 添加item
    ZCItemModel *IDCardItem = [ZCItemModel itemWithTitle:@"身份证查询" icon:@"s3" destVcClass:[ZCRootViewController class]];
    ZCItemModel *phoneItem = [ZCItemModel itemWithTitle:@"手机归属地" icon:@"a1" destVcClass:[ZCRootViewController class]];
    ZCItemModel *currencyItem = [ZCItemModel itemWithTitle:@"货币汇率" icon:@"a7" destVcClass:[ZCRootViewController class]];
    ZCItemModel *dreamItem = [ZCItemModel itemWithTitle:@"公交查询" icon:@"s4" destVcClass:[ZCRootViewController class]];
    ZCItemModel *IPItem = [ZCItemModel itemWithTitle:@"IP地址查询" icon:@"a5" destVcClass:[ZCRootViewController class]];
    
    [section.items addObjectsFromArray:@[IDCardItem, phoneItem, currencyItem, dreamItem, IPItem]];
    [self.sections addObject:section];
    
}

- (void)addSectionCalculate {
    
    ZCSectionModel *section = [ZCSectionModel defaultSection];
    section.headerTitle = @"贷款计算";
    
    ZCItemModel *houseItem = [ZCItemModel itemWithTitle:@"房贷计算" icon:@"a8" destVcClass:[ZCRootViewController class]];
    ZCItemModel *revenueItem = [ZCItemModel itemWithTitle:@"税收计算" icon:@"s7" destVcClass:[ZCRootViewController class]];
    
    [section.items addObjectsFromArray:@[houseItem, revenueItem]];
    [self.sections addObject:section];
    
}

- (void)addSectionTicket {
    
    ZCSectionModel *section = [ZCSectionModel defaultSection];
    section.headerTitle = @"彩票开奖";
    ZCItemModel *ticketItem = [ZCItemModel itemWithTitle:@"网易彩票" icon:@"a2" destVcClass:[ZCRootViewController class]];
    
    [section.items addObjectsFromArray:@[ticketItem]];
    [self.sections addObject:section];
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sections.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    ZCSectionModel *sectionModel = self.sections[section];
    return sectionModel.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 获得cell
    ZCItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    // 传递模型
    ZCSectionModel *sectionModel = self.sections[indexPath.section];
    cell.item = sectionModel.items[indexPath.row];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    // 如果是collectionView的HeaderView
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ZCSectionModel *sectionModel = self.sections[indexPath.section];
        
        static NSString *headerViewReuseID = @"ZCHeaderViewCell";
        ZCHeaderViewCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerViewReuseID forIndexPath:indexPath];
        
        cell.titleLabel.text = sectionModel.headerTitle;
        
        return cell;
    } else {
        
    }
    return nil;
}

#pragma mark <UICollectionViewDelegate>



@end
