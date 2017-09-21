//
//  main.m
//  AnalyticsFxMac
//
//  Created by osanai on 2017/08/29.
//  Copyright © 2017年 osanai. All rights reserved.
//

#define LOG(fmt, ...) printf("%s\n", [[NSString stringWithFormat:fmt, ##__VA_ARGS__] UTF8String])

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
        LOG(@"Hello, World!");
        
//        [[HstReader new] doLoad];
        
        const char *input = "/Users/osanai/Downloads/USDJPY.hst";
        const char *output = "/Users/osanai/Downloads/USDJPY.csv";
//        doLoadA(input,output);
        NSMutableArray *hoge = [NSMutableArray array];
        RateInfo *rates = doLoadB(input);

        AllRate *allRate = [AllRate new];
        
        for (int i=0;i<300000;i++) {
            RateInfo r = rates[i];
            LOG(@"open:%f",r.open);

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
                LOG(@"i%d/",i);
            }
        }
        
        
        [allRate calcMA];

        for (int i=0; i<allRate.rates.count; i++) {
            
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
//            LOG(content);
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
        
        
        
        
//        int buri = 60;    //◯分ぶりの◯猫
//        int saki = 1440 * 3;    //3日後
//        
//        // 確率計算
//        NSMutableArray *dosusTaka = [NSMutableArray array];
//        for (int i=0; i<50; i++) {
//            Dosu *dosu = [Dosu new];
//            dosu.min = 1 + i*10;
//            dosu.max = (i+1)*10;
//            [dosusTaka addObject:dosu];
//        }
//        Dosu *lastTaka = dosusTaka.lastObject;
//        lastTaka.max = saki;
//        
//        int maxTaka = ((Dosu *)dosusTaka.lastObject).max;
//        int souCountTaka = 0;
//        
//        //TODO:条件付き確率
//        //TODO:◯分まで高猫しなかった場合、それ以後高猫しない確率
//        for (int i=0; i<allRate.rates.count - maxTaka; i++) {
//            AllInfo1min *current = [allRate getAllInfo1min:i];
//            
//            if (current.takanekoTurmMin > buri) {
//                // 1週間ぶりの高猫なら
//                BOOL exist=NO;
//                for (int j=1; j<=maxTaka; j++) {
//                    AllInfo1min *after = [allRate getAllInfo1min:i+j];
//                    
//                    // N分後に高猫してる
//                    if (after.takanekoTurmMin > current.takanekoTurmMin) {
//                        souCountTaka++;
//                        
//                        for (Dosu *d in dosusTaka) {
//                            if (d.max >= j && d.min <= j) {
//                                d.count++;
//                            }
//                        }
//                        exist=YES;
//                        break;
//                    }
//                }
//            }
//        }
//        
//        // 高猫
//        for (Dosu *d in dosusTaka) {
//            double kakuritu = ((double)d.count/souCountTaka)*100.0;
//            LOG(@"1週間ぶりの高猫がきたら、%d分〜%d分に再高猫する確率%.2f％",(int)(d.min),(int)(d.max),kakuritu);
//        }
//        
//        LOG(@"");
//        
//        // 1〜N分に再高猫していなくて、N〜M分に再高猫する確率
//        for (int i=1; i<dosusTaka.count; i++) {
//            Dosu *dosu = dosusTaka[i];
//            Dosu *prev = dosusTaka[i-1];
//            
//            // それまでに高猫していない回数
//            int bosu = 0;
//            for (int j=0; j<i; j++) {
//                Dosu *d = dosusTaka[j];
//                bosu += d.count;
//            }
//            
//            double kakuritu = ((double)dosu.count/bosu)*100.0;
//            LOG(@"高猫後\t%d分\t再高猫していなくて、%d〜%d分に再高猫する確率\t%.2f％",(int)(prev.max),(int)(dosu.min),(int)(dosu.max),kakuritu);
//        }
//        
//        LOG(@"");
//        
//        // 1〜N分に再高猫していなくて、N〜3000分に再高猫しない確率
//        for (int i=1; i<dosusTaka.count; i++) {
//            Dosu *dosu = dosusTaka[i];
//            Dosu *prev = dosusTaka[i-1];
//            
//            // それまでに高猫していない回数
//            int bosu = 0;
//            for (int j=0; j<i; j++) {
//                Dosu *d = dosusTaka[j];
//                bosu += d.count;
//            }
//            int takaneko = 0;
//            for (int j=i; j<dosusTaka.count; j++) {
//                Dosu *d = dosusTaka[j];
//                takaneko += d.count;
//            }
//            
//            double kakuritu = (1.0 - (double)takaneko/bosu)*100.0;
////            LOG(@"高猫後\t%d分\t再高猫していなくて、%d〜3000分に再高猫しない確率\t%.2f％",(int)(prev.max),(int)(dosu.min),kakuritu);
//            LOG(@"%d\t分\t%d\t分\t%d\t分\t%.2f％",buri,saki,(int)(prev.max),kakuritu);
//        }
//        
//        //////////////安猫
//        
//        // 確率計算
//        NSMutableArray *dosusYasu = [NSMutableArray array];
//        for (int i=0; i<50; i++) {
//            Dosu *dosu = [Dosu new];
//            dosu.min = 1 + i*10;
//            dosu.max = (i+1)*10;
//            [dosusYasu addObject:dosu];
//        }
//        Dosu *lastYasu = dosusYasu.lastObject;
//        lastYasu.max = saki;
//        
//        int maxYasu = ((Dosu *)dosusYasu.lastObject).max;
//        int souCountYasu = 0;
//        
//        //TODO:条件付き確率
//        //TODO:◯分まで高猫しなかった場合、それ以後高猫しない確率
//        for (int i=0; i<allRate.rates.count - maxYasu; i++) {
//            AllInfo1min *current = [allRate getAllInfo1min:i];
//            
//            if (current.yasunekoTurmMin > buri) {
//                // 1週間ぶりの安猫なら
//                BOOL exist=NO;
//                for (int j=1; j<=maxYasu; j++) {
//                    AllInfo1min *after = [allRate getAllInfo1min:i+j];
//                    
//                    // N分後に安猫してる
//                    if (after.yasunekoTurmMin > current.yasunekoTurmMin) {
//                        souCountYasu++;
//                        
//                        for (Dosu *d in dosusYasu) {
//                            if (d.max >= j && d.min <= j) {
//                                d.count++;
//                            }
//                        }
//                        exist=YES;
//                        break;
//                    }
//                }
//            }
//        }
//        
//        // 高猫
//        for (Dosu *d in dosusYasu) {
//            double kakuritu = ((double)d.count/souCountYasu)*100.0;
//            LOG(@"1週間ぶりの安猫がきたら、%d分〜%d分に再安猫する確率%.2f％",(int)(d.min),(int)(d.max),kakuritu);
//        }
//        
//        LOG(@"");
//        
//        // 1〜N分に再高猫していなくて、N〜M分に再高猫する確率
//        for (int i=1; i<dosusYasu.count; i++) {
//            Dosu *dosu = dosusYasu[i];
//            Dosu *prev = dosusYasu[i-1];
//            
//            // それまでに高猫していない回数
//            int bosu = 0;
//            for (int j=0; j<i; j++) {
//                Dosu *d = dosusYasu[j];
//                bosu += d.count;
//            }
//            
//            double kakuritu = ((double)dosu.count/bosu)*100.0;
//            LOG(@"安猫後\t%d分\t再安猫していなくて、%d〜%d分に再安猫する確率\t%.2f％",(int)(prev.max),(int)(dosu.min),(int)(dosu.max),kakuritu);
//        }
//        
//        LOG(@"");
//        
//        // 1〜N分に再安猫していなくて、N〜3000分に再高猫しない確率
//        for (int i=1; i<dosusYasu.count; i++) {
//            Dosu *dosu = dosusYasu[i];
//            Dosu *prev = dosusYasu[i-1];
//            
//            // それまでに安猫していない回数
//            int bosu = 0;
//            for (int j=0; j<i; j++) {
//                Dosu *d = dosusYasu[j];
//                bosu += d.count;
//            }
//            int takaneko = 0;
//            for (int j=i; j<dosusYasu.count; j++) {
//                Dosu *d = dosusYasu[j];
//                takaneko += d.count;
//            }
//            
//            double kakuritu = (1.0 - (double)takaneko/bosu)*100.0;
//            LOG(@"%d\t分\t%d\t分\t%d\t分\t%.2f％",buri,saki,(int)(prev.max),kakuritu);
//        }
//
//
    }
    
    
    return 0;
}
