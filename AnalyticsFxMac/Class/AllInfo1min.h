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


//
+ (AllInfo1min *)createWithRateInfo:(RateInfo)rateInfo;

@end
