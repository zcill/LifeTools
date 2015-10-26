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
#import "ZCSearchHttpRequest.h"
#import "ZCWeatherModel.h"

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
    
#warning 未完成 定位
    
    // 监听定位城市改变的通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationCity) name:@"location_City_Note" object:nil];
    
    // 读取当前城市
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSString *city = [userDefaults objectForKey:@"currentCity"];
//    if (!city) {
//        city = @"南京";
//    }
    // 加载天气
    [self loadWeatherData:@"北京"];
    
    
    // 添加分组
    [self addSectionSearch];
    [self addSectionCalculate];
    [self addSectionTicket];
    

    
}

#pragma mark >>>>> 天气相关 >>>>>

// 收到定位城市通知
- (void)locationCity {
    
#warning 未完成城市定位单例类
    
}

// 获取城市天气数据
- (void)loadWeatherData:(NSString *)city {
    
    [ZCSearchHttpRequest getWeatherDataWithCity:city success:^(id JSON) {
        
        NSMutableArray *weatherInfo = [ZCWeatherModel objectArrayWithKeyValuesArray:JSON[@"results"]];
        _weatherModel = weatherInfo[0];
        
        // 实例化一个时间戳
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        // 设定时间格式
        [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
        // 用[NSDate date]可以获取系统当前时间
        NSString *currentTime = [dateFormatter stringFromDate:[NSDate date]];
        _weatherModel.date = currentTime;
        
        // 设置weatherView
        self.weatherCell.weatherModel = _weatherModel;
        
    } failure:^(NSError *error) {
        NSLog(@"加载天气失败");
        NSLog(@"error:%@", error);
    }];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:city forKey:@"currentCity"];
    
}


#pragma mark >>>>> collectionView界面相关 >>>>>

// 注册cell
- (void)registerCells {
    
    // 注册单个按钮cell
    [self.collectionView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    // 注册headerCell
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZCHeaderViewCell" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ZCHeaderViewCell"];
    
    // 注册weatherCell，使用第三方，保证可以悬停
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZCWeatherCell" bundle:nil] forSupplementaryViewOfKind:CSStickyHeaderParallaxHeader withReuseIdentifier:@"ZCWeatherCell"];
    
}

// 往section中添加item
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

// cell相关header和footer
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    // 如果是collectionView的HeaderView
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ZCSectionModel *sectionModel = self.sections[indexPath.section];
        
        static NSString *headerViewReuseID = @"ZCHeaderViewCell";
        ZCHeaderViewCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerViewReuseID forIndexPath:indexPath];
        
        cell.titleLabel.text = sectionModel.headerTitle;
        
        return cell;
        
    } else if ([kind isEqualToString:CSStickyHeaderParallaxHeader]) {
        
        ZCWeatherCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ZCWeatherCell" forIndexPath:indexPath];
        // 添加点击手势
        [cell addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapWeatherView)]];
        self.weatherCell = cell;
        if (!self.weatherModel) {
            
        } else {
            cell.weatherModel = self.weatherModel;
        }
        return cell;
        
    }
    return nil;
}

#pragma mark <UICollectionViewDelegate>

// 点击item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZCSectionModel *section = self.sections[indexPath.section];
    ZCItemModel *item = section.items[indexPath.row];
    
    // 运行block
    if (item.selectionHandler) {
        item.selectionHandler();
    }
    
    if (item.destVcClass) {
        UIViewController *viewController = [[item.destVcClass alloc] init];
        viewController.title = item.title;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}

#warning 点击WeatherView方法

- (void)tapWeatherView {
    
    
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
