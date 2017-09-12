//
//  HstReader.m
//  AnalyticsFxMac
//
//  Created by osanai on 2017/08/29.
//  Copyright © 2017年 osanai. All rights reserved.
//

#import "HstReader.h"
//#include <iostream>
//#include <fstream>
//#include <ctime>
//#include <iomanip>

//using namespace std;

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





@implementation HstReader

- (void)showLog {
    NSLog(@"ほげ");
}

//- (void)load {
//    // Read PNG file. Data is big endian, see http://www.w3.org/TR/PNG/#7Integers-and-byte-order
//    NSString *filePath = @"/Users/osanai/Downloads/USDJPY.hst";
//    NSData *data = [NSData dataWithContentsOfFile:filePath];
//    CCHBinaryDataReader *binaryDataReader = [[CCHBinaryDataReader alloc] initWithData:data options:CCHBinaryDataReaderBigEndian];
//    
//    // Skip file signature
//    [binaryDataReader setNumberOfBytesRead:0];
//    
//    // Read chunks, see http://www.w3.org/TR/PNG/#5Chunk-layout
//    while ([binaryDataReader canReadNumberOfBytes:44]) {
//        unsigned int length = [binaryDataReader readUnsignedInt];
//        NSString *chunkType = [binaryDataReader readStringWithNumberOfBytes:44 encoding:NSASCIIStringEncoding];
//        [binaryDataReader skipNumberOfBytes:length];
//        unsigned int crc = [binaryDataReader readUnsignedInt];
//        
//        NSLog(@"%@ length: %tu, crc: 0x%08x\n", chunkType, length, crc);
//    }
//}


#pragma mark -

- (NSString *) printHistoryHeader:(HistoryHeader)header
{
    NSMutableString *result = @"".mutableCopy;
    
    [result appendString:[NSString stringWithFormat:@"version   : %d\n",header.version]];
    [result appendString:[NSString stringWithFormat:@"copyright : %s\n",header.copyright]];
    [result appendString:[NSString stringWithFormat:@"symbol    : %s\n",header.symbol]];
    [result appendString:[NSString stringWithFormat:@"period    : %d\n",header.period]];
    [result appendString:[NSString stringWithFormat:@"digits    : %d\n",header.period]];
    
    time_t t1 = header.timesign;
    NSDate *time1 = [NSDate dateWithTimeIntervalSince1970:t1];
    [result appendString:[NSString stringWithFormat:@"timesign  : %@\n",time1]];

    time_t t2 = header.last_sync;
    NSDate *time2 = [NSDate dateWithTimeIntervalSince1970:t2];
    [result appendString:[NSString stringWithFormat:@"last_sync : %@\n",time2]];

    return result;
}

- (NSString *)printRate:(RateInfo)rate {

    NSMutableString *result = @"".mutableCopy;
    
    time_t t1 = rate.ctm;
    NSDate *time1 = [NSDate dateWithTimeIntervalSince1970:t1];
    
    [result appendString:[NSString stringWithFormat:@"timesign  : %@\n",time1]];
    [result appendString:[NSString stringWithFormat:@",%f,%f,%f,%f,%f\n",rate.open,rate.low,rate.high,rate.close,rate.vol]];
    
    return result;
}

- (void) doLoad
{
    NSInputStream *stream = [NSInputStream inputStreamWithFileAtPath:@"/Users/osanai/Downloads/USDJPY.hst"];
    if (stream == nil) {
        NSLog(@"NSInputStream 失敗");
        return;
    }
    
    HistoryHeader header;
    [stream read:(unsigned char*)&header maxLength:sizeof(header)];
    NSString *hs = [self printHistoryHeader:header];
    NSLog(@"header\n%@",hs);
    
    
//    uint8_t buffer[44];
    NSInteger len = 0;
    RateInfo rate;
    len = [stream read:(unsigned char*)&rate maxLength:sizeof(rate)];
    if (len) {
    }
    
//    NSData *data = [NSData dataWithBytes:&data length:sizeof(RateInfo)];
//    RateInfo rate;
//    [data getBytes:&rate length:sizeof(RateInfo)];
    
    NSString *rs = [self printRate:rate];
    NSLog(@"rate\n%@",rs);
    
//    
//    unsigned char sha1_result[CC_SHA1_DIGEST_LENGTH];
//    unsigned char* hash = NULL;
//    
//    // 初期化
//    CC_SHA1_Init(&ctx);
//    
//    long count = 0;
//    [stream open];
//    do {
//        count = [stream read: buffer maxLength:BUFFER_SIZE_FOR_READ];
//        //NSLog(@"読み込み結果 %3d", (int)count);
//        if (count > 0) {
//            CC_SHA1_Update(&ctx, (unsigned char*)buffer, (CC_LONG)count);
//        }
//    } while ([stream hasBytesAvailable]);
//    CC_SHA1_Final(sha1_result, &ctx);
//    
//    [stream close];
//    // エラー発生時
//    if (count < 0) {
//        return NULL;
//    }
//    
//    // 32バイト分の領域を確保して，そこにデータを詰める
//    hash = malloc(sizeof(unsigned char) * BUFFER_SIZE_FOR_HASH);
//    if (hash == NULL) {
//        return NULL;
//    }
//    // コピー
//    memcpy(hash, sha1_result, (long)CC_SHA1_DIGEST_LENGTH);
//    memcpy((hash + 20), buffer, 12);
//    return hash;

    
    
    
    
//
//    
//    
//    
//    
//    
//    ifstream ifs;
//    ifs.open(argv[1], ios::in | ios::binary);
//    if(!ifs) {
//        cout << "file open error" << endl;
//        return 1;
//    }
//    
//    HistoryHeader header;
//    ifs.read((char*)&header, sizeof(header));
//    if(ifs.bad()) {
//        cout << "file read error" << endl;
//        return 1;
//    }
//    
//    printHistoryHeader(header);
//    
//    ofstream ofs;
//    ofs.open(argv[2], ios::out | ios::trunc);
//    if(!ofs.is_open()) {
//        cout << "failed to create a file : " << argv[2] << endl;
//        return 1;
//    }
//    
//    RateInfo rate;
//    while(!ifs.eof()) {
//        ifs.read((char*)&rate, 44);
//        if(ifs.bad()) {
//            cout << "file read error" << endl;
//            return 1;
//        }
//        printRate(rate, ofs);
//    }
//    
//    cout << "done" << endl;
//    
//    return 0;
}

@end
