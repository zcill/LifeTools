//
//  ZCSearchHttpRequest.h
//  生活百事通
//
//  Created by 朱立焜 on 15/10/23.
//  Github: https://github.com/zcill
//  Copyright © 2015年 zcill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCSearchHttpRequest : NSObject

// 获取天气数据
+ (void)getWeatherDataWithCity:(NSString *)city success:(void (^)(id JSON))successBlock failure:(void (^)(NSError *error))failureBlock;

@end
