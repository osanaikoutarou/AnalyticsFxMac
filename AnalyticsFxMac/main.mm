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
#import "Dosu.h"

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
        
//        for (int i=0; i<allRate.rates.count; i++) {
//            AllInfo1min *current = [allRate getAllInfo1min:i];
//            
//            @try {
//                [fh seekToEndOfFile];
//                
//                NSData *data = [[NSString stringWithFormat:@"%ld\t%ld\t%f\t%f\n",current.takanekoTurmMin,current.yasunekoTurmMin,current.rate1min.high,current.rate1min.low] dataUsingEncoding:NSUTF8StringEncoding];
//                [fh writeData:data];
//            }
//            @catch (NSException * e) {
//                result = NO;
//            }
//        }
        
        // 確率計算
        NSMutableArray *dosus = [NSMutableArray array];
        for (int i=0; i<50; i++) {
            Dosu *dosu = [Dosu new];
            dosu.min = 1 + i*10;
            dosu.max = (i+1)*10;
            [dosus addObject:dosu];
        }
        Dosu *last = dosus.lastObject;
        last.max = 3000;
        
        int max = ((Dosu *)dosus.lastObject).max;
        int souCount = 0;
        
        //TODO:条件付き確率
        //TODO:◯分まで高猫しなかった場合、それ以後高猫しない確率
        for (int i=0; i<allRate.rates.count - max; i++) {
            AllInfo1min *current = [allRate getAllInfo1min:i];
            
            if (current.takanekoTurmMin > 7200) {
                // 1週間ぶりの高猫なら
                BOOL exist=NO;
                for (int j=1; j<=max; j++) {
                    AllInfo1min *after = [allRate getAllInfo1min:i+j];
                    
                    // N分後に高猫してる
                    if (after.takanekoTurmMin > current.takanekoTurmMin) {
                        souCount++;
                        
                        for (Dosu *d in dosus) {
                            if (d.max >= j && d.min <= j) {
                                d.count++;
                            }
                        }
                        exist=YES;
                        break;
                    }
                }
            }
        }
        
        // 高猫
        for (Dosu *d in dosus) {
            double kakuritu = ((double)d.count/souCount)*100.0;
            NSLog(@"1週間ぶりの高猫がきたら、%d分〜%d分に再高猫する確率%.2f％",(int)(d.min),(int)(d.max),kakuritu);
        }
        
        NSLog(@"");
        
        // 1〜N分に再高猫していなくて、N〜M分に再高猫する確率
        for (int i=1; i<dosus.count; i++) {
            Dosu *dosu = dosus[i];
            Dosu *prev = dosus[i-1];
            
            // それまでに高猫していない回数
            int bosu = 0;
            for (int j=0; j<i; j++) {
                Dosu *d = dosus[j];
                bosu += d.count;
            }
            
            double kakuritu = ((double)dosu.count/bosu)*100.0;
            NSLog(@"高猫後\t%d分\t再高猫していなくて、%d〜%d分に再高猫する確率\t%.2f％",(int)(prev.max),(int)(dosu.min),(int)(dosu.max),kakuritu);
        }
        
        NSLog(@"");
        
        // 1〜N分に再高猫していなくて、N〜3000分に再高猫しない確率
        for (int i=1; i<dosus.count; i++) {
            Dosu *dosu = dosus[i];
            Dosu *prev = dosus[i-1];
            
            // それまでに高猫していない回数
            int bosu = 0;
            for (int j=0; j<i; j++) {
                Dosu *d = dosus[j];
                bosu += d.count;
            }
            int takaneko = 0;
            for (int j=i; j<dosus.count; j++) {
                Dosu *d = dosus[j];
                takaneko += d.count;
            }
            
            double kakuritu = (1.0 - (double)takaneko/bosu)*100.0;
            NSLog(@"高猫後\t%d分\t再高猫していなくて、%d〜3000分に再高猫しない確率\t%.2f％",(int)(prev.max),(int)(dosu.min),kakuritu);
        }

    }
    
    
    return 0;
}
