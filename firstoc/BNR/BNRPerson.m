//
//  BNRPerson.m
//  firstoc
//
//  Created by leiming32 on 17/2/7.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import "BNRPerson.h"

const NSString *HELLO_WORLD = @"hello_world!";

@interface BNRPerson ()
//{
//    BOOL _goodPerson;//不能继承给子类
//}
//@property (nonatomic) BOOL goodPerson; //不能继承给子类
//子类只能访问父类.h文件声明的属性！
@end

@implementation BNRPerson

- (float) heightInMeters {
    return _heightInMeters;
}

- (void) setHeightInMeters:(float)h {
    _heightInMeters = h;
}

- (int) weightInKilos {
    return _weightInKilos;
}

- (void) setWeightInKilos:(int)w {
    _weightInKilos = w;
}

- (float) bodyMassIndex {
    return _weightInKilos / (_heightInMeters * _heightInMeters);
}

@end
