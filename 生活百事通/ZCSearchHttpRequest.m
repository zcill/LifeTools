//
//  ZCSearchHttpRequest.m
//  生活百事通
//
//  Created by 朱立焜 on 15/10/23.
//  Github: https://github.com/zcill
//  Copyright © 2015年 zcill. All rights reserved.
//

#import "ZCSearchHttpRequest.h"
#import "ZCHttpRequestTool.h"

#define WeatherURL @"http://api.map.baidu.com/telematics/v3/weather?"
//#define IDCardURL @"http://api.46644.com/idcard?"
#define IDCardURL @"http://api.jisuapi.com/idcard/query?"
#define baiduAppID @"9suGmKvdlUGlSGGRrkQLD108"
#define searchAppKey @"e810896de40995b7"

@implementation ZCSearchHttpRequest

+ (void)getWeatherDataWithCity:(NSString *)city success:(void (^)(id JSON))successBlock failure:(void (^)(NSError *error))failureBlock {
    
    // 设置请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"location"] = city;
    params[@"output"] = @"json";
    params[@"ak"] = baiduAppID;
    
    // 请求
    [ZCHttpRequestTool getWithURL:WeatherURL params:params success:^(id JSON) {
        if (successBlock) {
            successBlock(JSON);
        }
    } failure:^(NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    
}

+ (void)getIDCardDataWithIDCardNumber:(NSString *)IDCardNumber success:(void (^)(id JSON))successBlock failure:(void (^)(NSError *error))failureBlock {
    
    // 设置请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"idcard"] = IDCardNumber;
    params[@"appkey"] = searchAppKey;
    
    // 发送请求
    [ZCHttpRequestTool getWithURL:IDCardURL params:params success:^(id JSON) {
        if (successBlock) {
            successBlock(JSON);
        }
    } failure:^(NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    
}

@end
