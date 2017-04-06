//
//  BNRStockHolding.m
//  firstoc
//
//  Created by leiming32 on 17/2/7.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import "BNRStockHolding.h"

@implementation BNRStockHolding

- (float) costInDollars {
    return _buyPrice * _num;
}

- (float) valueInDollars {
    return _currentPrice * _num;
}

@end
