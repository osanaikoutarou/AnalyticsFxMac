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

- (void)calcMA {
    // 単純移動平均線

    int n;
    
    n=21;
    for (int i=0; i<self.rates.count; i++) {
        if (i-n<0) {continue;}
        double sum = 0;
        for (int j=1; j<=n; j++) {
            sum += ((AllInfo1min *)self.rates[i-j]).rate1min.close;
        }
        ((AllInfo1min *)(self.rates[i])).ma21_1min = sum / n;
    }
    
    n=21*5;
    for (int i=0; i<self.rates.count; i++) {
        if (i-n<0) {continue;}
        double sum = 0;
        for (int j=1; j<=n; j++) {
            sum += ((AllInfo1min *)self.rates[i-j]).rate1min.close;
        }
        ((AllInfo1min *)(self.rates[i])).ma21x5_1min = sum / n;
    }

    n=21*15;
    for (int i=0; i<self.rates.count; i++) {
        if (i-n<0) {continue;}
        double sum = 0;
        for (int j=1; j<=n; j++) {
            sum += ((AllInfo1min *)self.rates[i-j]).rate1min.close;
        }
        ((AllInfo1min *)(self.rates[i])).ma21x15_1min = sum / n;
    }

    n=21*60;
    for (int i=0; i<self.rates.count; i++) {
        if (i-n<0) {continue;}
        double sum = 0;
        for (int j=1; j<=n; j++) {
            sum += ((AllInfo1min *)self.rates[i-j]).rate1min.close;
        }
        ((AllInfo1min *)(self.rates[i])).ma21x60_1min = sum / n;
    }

    n=21*1440;
    for (int i=0; i<self.rates.count; i++) {
        if (i-n<0) {continue;}
        double sum = 0;
        for (int j=1; j<=n; j++) {
            sum += ((AllInfo1min *)self.rates[i-j]).rate1min.close;
        }
        ((AllInfo1min *)(self.rates[i])).ma21x1440_1min = sum / n;
    }

    n=21*7200;
    for (int i=0; i<self.rates.count; i++) {
        if (i-n<0) {continue;}
        double sum = 0;
        for (int j=1; j<=n; j++) {
            sum += ((AllInfo1min *)self.rates[i-j]).rate1min.close;
        }
        ((AllInfo1min *)(self.rates[i])).ma21x7200_1min = sum / n;
    }
    
    
    n=26;
    for (int i=0; i<self.rates.count; i++) {
        if (i-n<0) {continue;}
        double sum = 0;
        for (int j=1; j<=n; j++) {
            sum += ((AllInfo1min *)self.rates[i-j]).rate1min.close;
        }
        ((AllInfo1min *)(self.rates[i])).ma26_1min = sum / n;
    }
    
    n=26*5;
    for (int i=0; i<self.rates.count; i++) {
        if (i-n<0) {continue;}
        double sum = 0;
        for (int j=1; j<=n; j++) {
            sum += ((AllInfo1min *)self.rates[i-j]).rate1min.close;
        }
        ((AllInfo1min *)(self.rates[i])).ma26x5_1min = sum / n;
    }
    
    n=26*15;
    for (int i=0; i<self.rates.count; i++) {
        if (i-n<0) {continue;}
        double sum = 0;
        for (int j=1; j<=n; j++) {
            sum += ((AllInfo1min *)self.rates[i-j]).rate1min.close;
        }
        ((AllInfo1min *)(self.rates[i])).ma26x15_1min = sum / n;
    }
    
    n=26*60;
    for (int i=0; i<self.rates.count; i++) {
        if (i-n<0) {continue;}
        double sum = 0;
        for (int j=1; j<=n; j++) {
            sum += ((AllInfo1min *)self.rates[i-j]).rate1min.close;
        }
        ((AllInfo1min *)(self.rates[i])).ma26x60_1min = sum / n;
    }
    
    n=26*1440;
    for (int i=0; i<self.rates.count; i++) {
        if (i-n<0) {continue;}
        double sum = 0;
        for (int j=1; j<=n; j++) {
            sum += ((AllInfo1min *)self.rates[i-j]).rate1min.close;
        }
        ((AllInfo1min *)(self.rates[i])).ma26x1440_1min = sum / n;
    }
    
    n=26*7200;
    for (int i=0; i<self.rates.count; i++) {
        if (i-n<0) {continue;}
        double sum = 0;
        for (int j=1; j<=n; j++) {
            sum += ((AllInfo1min *)self.rates[i-j]).rate1min.close;
        }
        ((AllInfo1min *)(self.rates[i])).ma26x7200_1min = sum / n;
    }



}

@end
