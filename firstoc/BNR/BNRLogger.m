//
//  BNRLogger.m
//  firstoc
//
//  Created by leiming32 on 17/2/11.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import "BNRLogger.h"

@implementation BNRLogger

//使用NSDateFormatter格式输出self.lastTime
- (NSString *) lastTimeString {
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        NSLog(@"created dateFormatter");
    }
    return [dateFormatter stringFromDate:self.lastTime];
}

- (void)updateLastTime:(NSTimer *)t {
    NSDate *now = [NSDate date];
    self.lastTime = now;
    NSLog(@"just set time to : %@", [self lastTimeString]);
}

- (void)zoneChange:(NSNotification *)note {
    NSLog(@"the system time zone has changeed! %@", note);
}

-(void) dealloc {
    //从通知中心中删除。 通知中心不要持有观察者的强引用
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //另外，委托对象和数据源也要释放
    //setDelegate:nil  setDataSource:nil
    
    //对象不拥有目标  setTarget:nil
}

#pragma mark - NSURLConnectionDataDelegate
//收到一定字节数据后会被调用
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"received %lu bytes", [data length]);
    
    if (!_incomingData) {
        _incomingData = [[NSMutableData alloc] init];
    }
    
    [_incomingData appendData:data];
}

//最后一部分数据处理完成后会被调用
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"got it all! %lu", [_incomingData length]);
    NSString *string = [[NSString alloc] initWithData:_incomingData encoding:NSUTF8StringEncoding];
    _incomingData = nil;
    NSLog(@"connection received string has %lu chars", [string length]);
    
//    NSLog(@"connection received  string content:%@", string);
}

#pragma mark - NSURLConnectionDelegate的方法实现
//获取数据失败时调用
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"connection failed: %@", [error localizedDescription]);
    _incomingData = nil;
}


@end



