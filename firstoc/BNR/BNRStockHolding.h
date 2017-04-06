//
//  BNRStockHolding.h
//  firstoc
//
//  Created by leiming32 on 17/2/7.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

//股票
@interface BNRStockHolding : NSObject

@property (nonatomic) float buyPrice; //子类只能通过getset来访问
@property (nonatomic) float currentPrice;
@property (nonatomic) int num;

//{
//    float _buyPrice;   将实例变量通过@property的方式放在花括号外面，自动get set
//    float _currentPrice;
//    int _num;
//}

//买的时候的总价
- (float) costInDollars;

//当前市场价的总价
- (float) valueInDollars;


@end
