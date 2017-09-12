//
//  Rate.m
//  AnalyticsFxMac
//
//  Created by osanai on 2017/08/30.
//  Copyright © 2017年 osanai. All rights reserved.
//

#import "Rate1min.h"
#import "NSDate+Utilities.h"

@implementation Rate1min

+ (Rate1min *)createWithRateInfo:(RateInfo)rateInfo {
    Rate1min *rate1min = [Rate1min new];
    
    rate1min.open = rateInfo.open;
    rate1min.close = rateInfo.close;
    rate1min.high = rateInfo.high;
    rate1min.low = rateInfo.low;
    rate1min.daytime = [NSDate dateWithTimeIntervalSince1970:rateInfo.ctm];
    
    return rate1min;
}

// 最初の1分足
- (BOOL)isRefreshFirstTime:(AsiTime)asi {
    if (asi == k5min) {
        if (self.daytime.minute % 5 == 0) {
            return YES;
        }
        return NO;
    }
    if (asi == k15min) {
        if (self.daytime.minute % 15 == 0) {
            return YES;
        }
        return NO;
    }
    if (asi == k1hour) {
        if (self.daytime.minute == 0) {
            return YES;
        }
        return NO;
    }
    //世界でポピュラーなのは、NYクローズ（現地17時　日本夏時間AM6:00、冬時間AM7:00)に合わせて区切られたチャートです。
    //日足、４時間足は、NY17:00基準で作られるのが基本のようです。
    //ですが、メタトレーダーの場合
    //日足はサーバー時間 0時、４時間足は0,4,8,12,16,20,24と区切られていきます。
    //見ているチャートが変わってしまうという事態が発生しますので、自分が使用しているサーバーの時間基準はしっかり把握しておきましょう。
    
    //XMの場合、ギリシャ時間0時が基準（ロンドン2時間ズレ）
    //NYとロンドンは4時間なので、タイミング2時間ズレてる？
    //NY17 21 25...
    if (asi == k4hour) {
        if (self.daytime.hour%4 == 0 &&     // 一旦
            self.daytime.minute == 0) {
            return YES;
        }
        return NO;
    }
    //日足も一旦
    if (asi == k1day) {
        if (self.daytime.hour == 0 &&
            self.daytime.minute == 0) {
            return YES;
        }
        return NO;
    }
    if (asi == k1week) {
        NSDate *before = [self.daytime dateByAddingMinutes:-1];
        if (![self.daytime isSameWeekAsDate:before]) {
            return YES;
        }
        return NO;
    }
    if (asi == k1month) {
        NSDate *before = [self.daytime dateByAddingMinutes:-1];
        if (![self.daytime isSameMonthAsDate:before]) {
            return YES;
        }
        return NO;
    }



    return NO;
}

// 最後の1分足
- (BOOL)isRefreshEndTime:(AsiTime)asi {
    if (asi == k5min) {
        if (self.daytime.minute % 5 == 4) {
            return YES;
        }
        return NO;
    }
    if (asi == k15min) {
        if (self.daytime.minute % 5 == 14) {
            return YES;
        }
        return NO;
    }
    if (asi == k1hour) {
        if (self.daytime.minute == 59) {
            return YES;
        }
        return NO;
    }
    if (asi == k4hour) {
        if (self.daytime.hour%4 == 3 &&     // 一旦
            self.daytime.minute == 59) {
            return YES;
        }
        return NO;
    }
    //日足も一旦
    if (asi == k1day) {
        if (self.daytime.hour == 23 &&
            self.daytime.minute == 59) {
            return YES;
        }
        return NO;
    }
    if (asi == k1week) {
        NSDate *after = [self.daytime dateByAddingMinutes:1];
        if (![self.daytime isSameWeekAsDate:after]) {
            return YES;
        }
        return NO;
    }
    if (asi == k1month) {
        NSDate *after = [self.daytime dateByAddingMinutes:1];
        if (![self.daytime isSameMonthAsDate:after]) {
            return YES;
        }
        return NO;
    }




    return NO;
}

#pragma mark - 

// いらーんらんらん
//- (BOOL)isSummerTime {
//    
//}

@end
