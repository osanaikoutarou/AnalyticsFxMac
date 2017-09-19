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
        
        for (int i=0;i<300000;i++) {
            RateInfo r = rates[i];
            NSLog(@"open:%f",r.open);

            AllInfo1min *allinfo1min = [AllInfo1min createWithRateInfo:r];
            [allRate addRate:allinfo1min];
        }
        
        for (int i=0; i<allRate.rates.count; i++) {
            AllInfo1min *current = [allRate getAllInfo1min:i];
            
            for (int j=1; j<i; j++) {
                AllInfo1min *kako = [allRate getAllInfo1min:i-j];
                if (current.rate1min.high > kako.rate1min.high) {
                    current.takanekoTurmMin = j;
                }
                else {
                    current.takanekoStop = YES;
                }
                
                if (current.rate1min.low < kako.rate1min.low) {
                    current.yasunekoTurmMin = j;
                }
                else {
                    current.yasunekoStop = YES;
                }
                
                if (current.yasunekoStop && current.takanekoStop) {
                    break;
                }
            }
            
            if (i%5000==0) {
                NSLog(@"i%d/",i);
            }
        }
        
        // /Documentのパスの取得
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        // ファイル名の作成
        NSString *filename = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"sample.txt"];
        NSFileHandle* fh = [NSFileHandle fileHandleForWritingAtPath:filename];
        if ( !fh ) {
            [[NSFileManager defaultManager] createFileAtPath:filename contents:nil attributes:nil];
            fh = [NSFileHandle fileHandleForWritingAtPath:filename];
        }
        NSError *error;
        BOOL result;
//        // ファイルへの保存
//        BOOL result = [sample writeToFile:filename atomically:YES encoding:NSUTF8StringEncoding error:&error];
//        if(result){
//            // ファルからの読込み
//            NSString *content = [NSString stringWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:&error];
//            NSLog(content);
//        }
        
        for (int i=0; i<allRate.rates.count; i++) {
            AllInfo1min *current = [allRate getAllInfo1min:i];
            
            @try {
                [fh seekToEndOfFile];
                
                NSData *data = [[NSString stringWithFormat:@"%ld\t%ld\t%f\t%f\n",current.takanekoTurmMin,current.yasunekoTurmMin,current.rate1min.high,current.rate1min.low] dataUsingEncoding:NSUTF8StringEncoding];
                [fh writeData:data];
            }
            @catch (NSException * e) {
                result = NO;
            }
        }
        
//        [allRate calcMA:21];
        
    }
    
    
    return 0;
}
