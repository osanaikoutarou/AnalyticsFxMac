//
//  LoaderCpp.hpp
//  AnalyticsFxMac
//
//  Created by osanai on 2017/08/30.
//  Copyright © 2017年 osanai. All rights reserved.
//

#ifndef LoaderCpp_hpp
#define LoaderCpp_hpp

#include <stdio.h>
#include <iostream>
#include <fstream>
#include <ctime>
#include <iomanip>

#endif /* LoaderCpp_hpp */

typedef struct _HistoryHeader
{
    uint32_t    version;
    char        copyright[64];
    char        symbol[12];
    int32_t     period;
    int32_t     digits;
    uint32_t    timesign;
    uint32_t    last_sync;
    uint32_t    reserved[13];
} HistoryHeader;

#pragma pack(push,1)
typedef struct _RateInfo
{
    uint32_t    ctm;
    double      open;
    double      low;
    double      high;
    double      close;
    double      vol;
} RateInfo;
#pragma pack(pop)

RateInfo *doLoadB(const char* filepath);
//int doLoadA(char* filepath, char* outpath);
