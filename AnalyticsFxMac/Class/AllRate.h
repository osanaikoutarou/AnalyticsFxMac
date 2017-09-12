//
//  AllRate.h
//  AnalyticsFxMac
//
//  Created by osanai on 2017/09/12.
//  Copyright © 2017年 osanai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AllInfo1min.h"
#import "Rate1min.h"

@interface AllRate : NSObject

@property (nonatomic) NSMutableArray *rates;

- (void)addRate:(AllInfo1min *)allInfo1min;

- (void)calcMA:(NSInteger)n;

@end
