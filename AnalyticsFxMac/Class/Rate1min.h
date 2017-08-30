//
//  Rate.h
//  AnalyticsFxMac
//
//  Created by osanai on 2017/08/30.
//  Copyright © 2017年 osanai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoaderCpp.hpp"

typedef NS_ENUM(NSUInteger, AsiTime) {
    k1min,
    k5min,
    k15min,
    k30min,
    k1hour,
    k4hour,
    k1day,
    k1week,
    k1month,
};

@interface Rate1min : NSObject

@property (nonatomic) NSDate *daytime;
@property (nonatomic) double open;
@property (nonatomic) double low;
@property (nonatomic) double high;
@property (nonatomic) double close;
@property (nonatomic) double vol;

// 最初の1分足
- (BOOL)isRefreshFirstTime:(AsiTime)asi;
// 最後の1分足
- (BOOL)isRefreshEndTime:(AsiTime)asi;

+ (void)createWithRateInfo:(RateInfo)rateInfo;

@end
