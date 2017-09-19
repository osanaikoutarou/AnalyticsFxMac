//
//  AllRate.m
//  AnalyticsFxMac
//
//  Created by osanai on 2017/09/12.
//  Copyright © 2017年 osanai. All rights reserved.
//

#import "AllRate.h"

@implementation AllRate

- (instancetype)init {
    self = [super init];
    if (self) {
        self.rates = [NSMutableArray array];
    }
    return self;
}

- (void)addRate:(AllInfo1min *)allInfo1min {
    [self.rates addObject:allInfo1min];
}

- (AllInfo1min *)getAllInfo1min:(NSInteger)index {
    return self.rates[index];
}

- (void)calcMA:(NSInteger)n {
    // 単純移動平均線
    
    for (int i=0; i<self.rates.count; i++) {
        if (i-n<0) {
            continue;
        }

        double sum = 0;
        for (int j=1; j<=n; j++) {
            sum += ((AllInfo1min *)self.rates[i-j]).rate1min.close;
        }
        ((AllInfo1min *)(self.rates[i])).ma21_1min = sum / n;
        
        NSLog(@"21ma %f",((AllInfo1min *)self.rates[i]).ma21_1min);
    }
}

@end
