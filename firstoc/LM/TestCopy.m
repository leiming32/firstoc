//
//  TestCopy.m
//  firstoc
//
//  Created by leiming32 on 17/3/31.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import "TestCopy.h"

@interface TestCopy ()

//这里copy， 是当它使用=被赋值另一个nsstring或nsmutableString的时候，让对方使用copy来赋值. 如果=右边是
//NSMutableString，那么就是新建对象。
@property (nonatomic, copy) NSString *strCopy;
@property (nonatomic) NSString *str;

@property (nonatomic, copy) NSArray *arrCopy;
@property (nonatomic) NSArray *arr;

@end

@implementation TestCopy

/**
 1. 测试NSString copy方法与mutableCopy方法
 */
- (void)testNSStringCopy {
    [self printStart:__FUNCTION__];
    
    //1.在字符串是直接赋值的，是否生成新对象是和=右边有关的
    //temp是NSString的情况下，如果=右边是mutableCopy才会生成新对象。
    NSString *temp = @"aabb";
    NSString *test2 = [temp copy];//不生成新对象.返回指向自己的指针!
    NSString *test3 = [temp mutableCopy];//生成新对象. 深拷贝！返回一个可变的string
    NSLog(@"temp: %@, - %p", temp, temp);
    NSLog(@"test2 copy: %@, - %p, %@, %d", test2, test2, [test2 class], [test2 isKindOfClass:[NSMutableString class]]);//这里的isKindOfclass居然返回1，无法理解!
    NSLog(@"test3 mutableCopy: %@, - %p, %@, %d", test3, test3, [test3 class], [test3 isKindOfClass:[NSMutableString class]]);
    
    
    //1.1 测一下test2的可变性
//    NSMutableString *test2_mut = (NSMutableString *) test2;
//    [test2_mut appendString:@"ok"];//error:reason: 'Attempt to mutate immutable object with appendString:'
//    NSLog(@"test2_mut:%@", test2_mut);
    
    //1.2 测一下test3的可变性
    NSMutableString *test3_mut = (NSMutableString *) test3;
    [test3_mut appendString:@"ok"];
    NSLog(@"test3_mut:%@", test3_mut);
    
    //2. temp是NSMutableString的情况下，都会生成新对象！
    NSMutableString *mutTemp = [NSMutableString stringWithString:@"ccdd"];
    NSString *mutTest2 = [mutTemp copy];//生成新对象
    NSString *mutTest3 = [mutTemp mutableCopy];//生成新对象
    NSLog(@"mutTemp: %@, - %p", mutTemp, mutTemp);
    NSLog(@"mutTest2 copy: %@, - %p, %@", mutTest2, mutTest2, [mutTest2 class]);
    NSLog(@"mutTest3 mutableCopy: %@, - %p, %@", mutTest3, mutTest3, [mutTest3 class]);
    
    //2.1 测一下mutTest2的可变性
//    NSMutableString *mutTest2_mut = (NSMutableString *) mutTest2;
//    [mutTest2_mut appendString:@"ok"];//error! 不认识appendString方法。 说明NSMutableString的copy方法返回的是一个不可变string!
//    NSLog(@"mutTest2_mut:%@", mutTest2_mut);
    
    //总结:
    //nsstring的copy不新建对象，mutableCopy会新建对象. mutableCopy返回一个可变string
    //nsmutabelString的copy和mutableCopy都会新建对象. copy返回一个不可变string。
    
    [self printEnd:__FUNCTION__];
}

/**
 2. 测试带copy的属性 
 @property (nonatomic, copy) NSString *strCopy;
 
 通过=号来赋值的时候，调用右侧nsstring或mutableString的copy方法！
 */
- (void)testNSStringCopy2 {
    [self printStart:__FUNCTION__];
    
    //1. 通过=号来赋值, 右侧是NSString
    NSString *temp = @"aabb";
    self.strCopy = temp;//不生成新对象
    self.str = temp;//不生成新对象
    NSLog(@"temp:%@, - %p", temp, temp);//打印对象内存地址  &mutStr就是指针变量的地址
    NSLog(@"strCopy:%@, - %p", self.strCopy, self.strCopy);
    NSLog(@"strStrong:%@, - %p", self.str, self.str);

    
    //2. 通过=号来赋值, 右侧是NSMutableString
    NSMutableString *mutStr = [NSMutableString stringWithFormat:@"ccdd"];
    self.strCopy = mutStr;//生成新对象， 不可变对象
    self.str = mutStr;//不生成新对象     注意：即使右边nsmutableString，也不会新建对象！
    NSLog(@"mutStr:%@, - %p", mutStr, mutStr);//打印对象内存地址  &mutStr就是指针变量的地址
    NSLog(@"strCopy:%@, - %p", self.strCopy, self.strCopy);
    NSLog(@"strStrong:%@, - %p", self.str, self.str);
    NSLog(@"-----------修改----------------------");
    [mutStr appendString:@"--ok"];
    NSLog(@"mutStr:%@, - %p", mutStr, mutStr);
    NSLog(@"strCopy:%@, - %p", self.strCopy, self.strCopy);
    NSLog(@"strStrong:%@, - %p", self.str, self.str);
    
//    NSMutableString *strCopy_mut = (NSMutableString *)self.strCopy;
//    [strCopy_mut appendString:@"==ok"]; //error! 不可变string
    
    //总结：
    //带copy的nsstring主要是针对当=赋值时，右侧是nsmutableString的情况，需要调用右方的copy方法生成新实例.（也是一个不可变string）。
    //如果不带copy，则不会调用右方的copy方法，而是引用计数加1.
    
    [self printEnd:__FUNCTION__];
}

/**
 3. 测试NSArray copy方法与mutableCopy方法
 */
- (void)testNSArrayCopy {
    [self printStart:__FUNCTION__];
    
    NSArray *temp = @[@"aa", @"bb"];
    NSArray *test2 = [temp copy];//不生成新对象，返回指向自己的指针!
    NSArray *test3 = [temp mutableCopy];//生成新对象，可变的array
    NSLog(@"temp: %@, - %p", temp, temp);
    NSLog(@"test2 copy: %@, - %p, %@, %d", test2, test2, [test2 class], [test2 isKindOfClass:[NSMutableArray class]]);//这里的isKindOfclass返回0
    NSLog(@"test3 mutableCopy: %@, - %p, %@, %d", test3, test3, [test3 class], [test3 isKindOfClass:[NSMutableArray class]]);
    
    //1.1 测一下test2的可变性
//    NSMutableArray *test2_mut = (NSMutableArray *) test2;
//    [test2_mut addObject:@"ok"]; //error, 不可变对象！
//    NSLog(@"test2_mut:%@", test2_mut);
    
    //1.2 测一下test3的可变性
    NSMutableArray *test3_mut = (NSMutableArray *) test3;
    [test3_mut addObject:@"ok"];//ok
    NSLog(@"test3_mut:%@", test3_mut);
    
    //2. temp是NSMutableString的情况下，都会生成新对象！
    NSMutableArray *mutTemp = [NSMutableArray arrayWithArray:@[@"aa", @"bb"]];
    NSArray *mutTest2 = [mutTemp copy];//生成新对象，不可变array
    NSArray *mutTest3 = [mutTemp mutableCopy];//生成新对象，可变array
    NSLog(@"mutTemp: %@, - %p", mutTemp, mutTemp);
    NSLog(@"mutTest2 copy: %@, - %p, %@", mutTest2, mutTest2, [mutTest2 class]);
    NSLog(@"mutTest3 mutableCopy: %@, - %p, %@", mutTest3, mutTest3, [mutTest3 class]);
    
    //2.1 测一下mutTest2的可变性
//    NSMutableArray *mutTest2_mut = (NSMutableArray *) mutTest2;
//    [mutTest2_mut addObject:@"ok"];//error! 不认识addObject方法。 说明NSMutableArray的copy方法返回的是一个不可变array!
//    NSLog(@"mutTest2_mut:%@", mutTest2_mut);
    
    //总结:
    //NSArray的copy不新建对象，mutableCopy会新建对象. mutableCopy返回一个可变array
    //NSMutableArray的copy和mutableCopy都会新建对象. copy返回一个不可变array
    
    [self printEnd:__FUNCTION__];
}

- (void)testNSArrayCopy2 {
    [self printStart:__FUNCTION__];
    
    //1. 通过=号来赋值, 右侧是NSString
    NSArray *temp = @[@"aa", @"bb"];
    self.arrCopy = temp;//不生成新对象
    self.arr = temp;//不生成新对象
    NSLog(@"temp:%@, - %p", temp, temp);//打印对象内存地址  &mutStr就是指针变量的地址
    NSLog(@"arrCopy:%@, - %p", self.arrCopy, self.arrCopy);
    NSLog(@"arrStrong:%@, - %p", self.arr, self.arr);
    
    
    //2. 通过=号来赋值, 右侧是NSMutableString
    NSMutableArray *mutArr = [NSMutableArray arrayWithArray:@[@"aa", @"bb"]];
    self.arrCopy = mutArr;//生成新对象, 不可变对象
    self.arr = mutArr;//不生成新对象
    NSLog(@"mutArr:%@, - %p", mutArr,mutArr);
    NSLog(@"arrCopy:%@, - %p", self.arrCopy, self.arrCopy);
    NSLog(@"arrStrong:%@, - %p", self.arr, self.arr);
    NSLog(@"-----------修改----------------------");
    [mutArr addObject:@"--ok"];
    NSLog(@"mutArr:%@, - %p", mutArr, mutArr);
    NSLog(@"arrCopy:%@, - %p", self.arrCopy, self.arrCopy);
    NSLog(@"arrStrong:%@, - %p", self.arr, self.arr);
    
//    NSMutableArray *arrCopy_mut = (NSMutableArray *)self.arrCopy;
//    [arrCopy_mut addObject:@"==ok"]; //error! 不可变array
    
    //总结：
    //带copy的nsstring主要是针对当=赋值时，右侧是nsmutableString的情况，需要调用右方的copy方法生成新实例.（也是一个不可变string）。
    //如果不带copy，则不会调用右方的copy方法，而是引用计数加1.
    
    [self printEnd:__FUNCTION__];
}

- (void)printStart:(const char *)funName {
    NSLog(@"%s >>>>>>>start...", funName);
}

- (void)printEnd:(const char *)funName {
    NSLog(@"%s <<<<<<<<< end!", funName);
}

@end
