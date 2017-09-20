//
//  Dosu.h
//  AnalyticsFxMac
//
//  Created by osanai on 2017/09/20.
//  Copyright © 2017年 osanai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dosu : NSObject

@property (nonatomic) double min;
@property (nonatomic) double max;
@property (nonatomic) int count;

@property (nonatomic) int notCount; //しなかった回数

@end
