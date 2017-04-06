//
//  BNREmployee.h
//  firstoc
//
//  Created by leiming32 on 17/2/8.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import "BNRPerson.h"
@class BNRAsset; //不需要知道细节，只需要知道有这个类就可以

@interface BNREmployee : BNRPerson

//隐藏可变属性，放在.m中
//{//放在proerty前面
//    NSMutableArray *_assets;
//}

@property (nonatomic, copy) NSString *lastName;
@property (nonatomic) unsigned int employeeID;
//@property (nonatomic) unsigned int officeAlarmCode; 私有化
@property (nonatomic) NSDate *hireDate;
//@property (nonatomic, copy) NSArray *assets;
@property (nonatomic, copy) NSSet *assets;//一个员工有多件不重复的物品

- (double) yearsOfEmployment;
- (void)addAsset:(BNRAsset *)a;
- (unsigned int) valueOfAsset;

@end
