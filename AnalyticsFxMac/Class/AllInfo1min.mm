//
//  AllInfo1min.m
//  AnalyticsFxMac
//
//  Created by osanai on 2017/08/30.
//  Copyright © 2017年 osanai. All rights reserved.
//

#import "AllInfo1min.h"

@implementation AllInfo1min

+ (AllInfo1min *)createWithRateInfo:(RateInfo)rateInfo {
    AllInfo1min *allInfo1min = [AllInfo1min new];
    allInfo1min.rate1min = [Rate1min createWithRateInfo:rateInfo];
    
    return allInfo1min;
}

@end
