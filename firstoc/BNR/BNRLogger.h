//
//  BNRLogger.h
//  firstoc
//
//  Created by leiming32 on 17/2/11.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

//协议
@interface BNRLogger : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
{
    NSMutableData *_incomingData;
}

@property (nonatomic) NSDate *lastTime;

- (NSString *)lastTimeString;
- (void)updateLastTime:(NSTimer *)t;
- (void)zoneChange:(NSNotification *)note;

@end
