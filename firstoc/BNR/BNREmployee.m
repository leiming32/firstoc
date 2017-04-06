//
//  BNREmployee.m
//  firstoc
//
//  Created by leiming32 on 17/2/8.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import "BNREmployee.h"
#import "BNRAsset.h"

//这里是类扩展 class extensions。  声明私有的属性，只有当前.h中才能使用这里的属性！
@interface BNREmployee() {
    //定义实例变量放在花括号里，花括号要放在@property前面
    //同时定义实例变量和属性_assets，属性对外暴露NSArray，实际是NSMutableArray.  把它放在类扩展中，彻底隐藏了可变属性！
    NSMutableArray *_assets;
}

@property (nonatomic) unsigned int officeAlarmCode; //私有化的属性
@end

@implementation BNREmployee

- (double) yearsOfEmployment {
    if (self.hireDate) {//不为nil
        NSDate *now = [NSDate date];
        NSTimeInterval secs = [now timeIntervalSinceDate:self.hireDate];
        return secs / 31557600.0;
    } else {
        return 0;
    }
}

//方法覆盖
- (float) bodyMassIndex {
//    return 10;
    float b = [super bodyMassIndex]; //super使用父类的方法
    return b * 0.9 + _officeAlarmCode;
}

- (NSString *) description {
    return [NSString stringWithFormat:@"employee id:%d, assetvalue:%u, w:%d, h:%f", self.employeeID, self.valueOfAsset, self.weightInKilos,
            self.heightInMeters];
}

//重写回收方法
- (void) dealloc {
    NSLog(@"deallocating %@", self);
}

//_assets的存取
- (void) setAssets:(NSArray *)a {
    _assets = [a mutableCopy];
}
- (NSArray *) assets {
    return [_assets copy];
}


-(void)addAsset:(BNRAsset *)a {
    if (!_assets) { //为空
        _assets = [[NSMutableArray alloc] init];
    }
    [_assets addObject:a];
    a.holder = self;//指定holder
}

- (unsigned int)valueOfAsset {
    //累加转售价格
    unsigned int sum = 0;
    for (BNRAsset *a in _assets) {
        sum += a.resaleValue;
    }
    return sum;
}


@end
