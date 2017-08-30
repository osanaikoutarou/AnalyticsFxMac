//
//  Rate.m
//  AnalyticsFxMac
//
//  Created by osanai on 2017/08/30.
//  Copyright © 2017年 osanai. All rights reserved.
//

#import "Rate1min.h"

@implementation Rate1min

+ (void)createWithRateInfo:(RateInfo)rateInfo {
    Rate1m *rate1m = [Rate1m new];
    
    rate1m.open = rateInfo.open;
    rate1m.close = rateInfo.close;
    rate1m.high = rateInfo.high;
    rate1m.low = rateInfo.low;
    rate1m.daytime = [NSDate dateWithTimeIntervalSince1970:rateInfo.ctm];
    
}

@end
