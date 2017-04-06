//
//  BNRPerson.h
//  firstoc
//
//  Created by leiming32 on 17/2/7.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

//全局变量在.h文件中声明，带extern.   在.m中定义。
extern const NSString *HELLO_WORLD;

@interface BNRPerson : NSObject {
    //两个实例变量 花括号里面  _开头，惯例,容易区分实例变量和局部变量
    float _heightInMeters;
    int _weightInKilos;
}

//五个实例方法 花括号外面
- (float) heightInMeters;
- (void) setHeightInMeters:(float)h;
- (int) weightInKilos;
- (void) setWeightInKilos:(int)w;
- (float) bodyMassIndex;

@end
