//
//  BNRAsset.m
//  firstoc
//
//  Created by leiming32 on 17/2/8.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import "BNRAsset.h"

@implementation BNRAsset

- (NSString *) description {
    if (self.holder) {
        return [NSString stringWithFormat:@"<label:%@, resale:$%u, holder:%@>", _label, _resaleValue, _holder];
    } else {
        return [NSString stringWithFormat:@"<label:%@, resale:$%u>", self.label, self.resaleValue];
    }

}

- (void)dealloc {
    NSLog(@"deallocating %@", self);
}

@end
