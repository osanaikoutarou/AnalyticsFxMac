//
//  AllInfo1min.h
//  AnalyticsFxMac
//
//  Created by osanai on 2017/08/30.
//  Copyright © 2017年 osanai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Rate1min.h"

@interface AllInfo1min : NSObject

@property (nonatomic) NSInteger date;
@property (nonatomic) Rate1min *rate1min;
//@property (nonatomic) Rate1min *rate5min;
//@property (nonatomic) Rate1min *rate15min;
//@property (nonatomic) Rate1min *rate1hour;
//@property (nonatomic) Rate1min *rate4hour;
//@property (nonatomic) Rate1min *rate1day;
//@property (nonatomic) Rate1min *rate1week;
//@property (nonatomic) Rate1min *rate1month;

//
@property (nonatomic) double ma21_1min;
@property (nonatomic) double ma21x5_1min;
@property (nonatomic) double ma21x15_1min;
@property (nonatomic) double ma21x60_1min;
@property (nonatomic) double ma21x240_1min;
@property (nonatomic) double ma21x1440_1min;
@property (nonatomic) double ma21x7200_1min;
@property (nonatomic) double ma26_1min;
@property (nonatomic) double ma26x5_1min;
@property (nonatomic) double ma26x15_1min;
@property (nonatomic) double ma26x60_1min;
@property (nonatomic) double ma26x240_1min;
@property (nonatomic) double ma26x1440_1min;
@property (nonatomic) double ma26x7200_1min;


@property (nonatomic) NSInteger takanekoTurmMin;    //何分ぶりの高猫か
@property (nonatomic) NSInteger yasunekoTurmMin;    //何分ぶりの安猫か
@property (nonatomic) BOOL takanekoStop;
@property (nonatomic) BOOL yasunekoStop;

//
+ (AllInfo1min *)createWithRateInfo:(RateInfo)rateInfo;

@end
