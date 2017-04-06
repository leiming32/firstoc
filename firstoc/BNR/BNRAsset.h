//
//  BNRAsset.h
//  firstoc
//
//  Created by leiming32 on 17/2/8.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BNREmployee;

@interface BNRAsset : NSObject

@property (nonatomic, copy) NSString *label;
@property (nonatomic) unsigned int resaleValue;
@property (nonatomic, weak) BNREmployee *holder;//弱引用，避免强引用循环

@end
