//
//  main.m
//  AnalyticsFxMac
//
//  Created by osanai on 2017/08/29.
//  Copyright © 2017年 osanai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HstReader.h"
#import "LoaderCpp.hpp"
#import "Rate1min.h"
#import "AllInfo1min.h"
#import "AllRate.h"

extern RateInfo *doLoadB(const char* filepath);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
//        [[HstReader new] doLoad];
        
        const char *input = "/Users/osanai/Downloads/USDJPY.hst";
        const char *output = "/Users/osanai/Downloads/USDJPY.csv";
//        doLoadA(input,output);
        NSMutableArray *hoge = [NSMutableArray array];
        RateInfo *rates = doLoadB(input);

        AllRate *allRate = [AllRate new];
        
        for (int i=0;i<1000;i++) {
            RateInfo r = rates[i];
            NSLog(@"open:%f",r.open);

            AllInfo1min *allinfo1min = [AllInfo1min createWithRateInfo:r];
            [allRate addRate:allinfo1min];
            
        }
        
        [allRate calcMA:21];
        
    }
    
    
    return 0;
}
