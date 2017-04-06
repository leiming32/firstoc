//
//  main.m
//  firstoc  从13章开始就是oc了。前12章都是c
//
//  Created by leiming32 on 17/1/26.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h> //苹果库

//#import "BNRPerson.h"//当前项目中
#import "BNREmployee.h"

#import "BNRStockHolding.h"

#import "BNRAsset.h"

#import "BNRLogger.h"

#import "TestCopy.h"

//外部变量
NSString const *TEST_DIR = @"/Users/leiming32/ios/fortest";

//对象
void study13() {
    /**
     消息发送。 NSDate实例的date方法
     消息发送后，执行date方法，在堆上分配一块内存，并初始化为当时间时间并返回当前对象的地址
     */
    NSDate *now = [NSDate date];//接收方  选择器
    NSLog(@"date: %p, %@", now, now);   // %@输出对象的描述信息
    
    double seconds = [now timeIntervalSince1970];
    NSLog(@"timeIntervalSince1970: %f", seconds);
    
    //        double testSeconds = [NSDate timeIntervalSince1970];//error! 选择器不匹配
    //        NSDate *testNow = [now date]; // error!
    
    //        double testSeconds2 = [now timeintervalSince1970];//大小写！
}

//13章课后作业.  输出计算机的名字
void homework13() {
    NSHost *host = [NSHost currentHost];
    NSString *name = [host localizedName];
    NSLog(@"host name: %@", name);
}

/**
 实参传递
 */
void study14() {
    NSDate *now = [NSDate date];//接收方  选择器
    //单个实参
    NSDate *later = [now dateByAddingTimeInterval:100000];//一万秒以后的时间, 后面是实参，冒号是方法名的一部分
    NSLog(@"一万秒以后是：%@\n", later);
    
    //多个实参   计算某个日期是相应月份中的几号
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSLog(@"my cal  is %@, calendarIdentifier: %@\n", cal, [cal calendarIdentifier]);
    
    //方法名由三部分组成。 前两个实参传入常量，以表示类型。   今天是这个月的第几天。 冒号对齐
    unsigned long day = [cal ordinalityOfUnit:NSDayCalendarUnit
                                       inUnit:NSMonthCalendarUnit
                                      forDate:now];
    NSLog(@"this is the day %lu of the month", day);
    
    //这周是这个月的每几周
    unsigned long week = [cal ordinalityOfUnit:NSWeekCalendarUnit
                                        inUnit:NSMonthCalendarUnit
                                       forDate:now];
    NSLog(@"this is the week %lu of the month", week);
    
    //消息嵌套发送
    double seconds2 = [[NSDate date] timeIntervalSince1970]; //参考上面的seconds
    //alloc+init必须以嵌套的形式发送消息. 新建并初始化一个对象,并返回实例的地址.
    NSDate *now2 = [[NSDate alloc] init]; //嵌套发消息等同于[NSDate date]
    
    //oc可以向nil发送消息。   即调用nil对象的方法。 不会出现空指针错误，得到返回值为0，无意义.
    //        Dog *dog = nil;
    //        [dog eat]; 不出错
    
    id sth;// 当不知道指向什么类型的指针时，就用id，且不用写*号。
}

//14章作业，计算从出生到当前时刻的时间间隔，单位是秒
void homework14() {
    //使用NSDateComponents来创建一个日期对象
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:1984];
    [comps setMonth:12];
    [comps setDay:23];
    [comps setHour:13];
    [comps setMinute:0];
    [comps setSecond:0];
    
    NSCalendar *g = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *dateOfBirth = [g dateFromComponents:comps];
    
    NSDate *now = [[NSDate alloc] init];
    
    //timeIntervalSinceDate 计算从dateofbirth到now之间的秒数
    double secondsSinceBirth = [now timeIntervalSinceDate:dateOfBirth];
    
    NSLog(@"time since birth: %f", secondsSinceBirth);
}

//对象与内存
void study15() {
    //ARC automatic reference couting 自动引用计数  项目开启ARC，当对象引用计数为0时即被销毁、。
}

//NSString
void study16() {
    //动态字符串
    NSDate *now = [NSDate date];
    NSString *dateString = [NSString stringWithFormat:@"time now is %@", now];
    NSLog(@"dateString: %@", dateString);
    
    //参考文档 本地？
    
    
}

void homework16() {
    //todo
}

//NSArray
void study17() {
    NSDate *now = [NSDate date];
    NSDate *tomorrow = [now dateByAddingTimeInterval:24 * 60 * 60];
    NSDate *yesterday = [now dateByAddingTimeInterval:-24 * 60 * 60];
    
    NSArray *arr = @[now, tomorrow, yesterday]; //也是一个堆对象，它里面三个index，顺序不能变了。
    NSLog(@"总共%lu个元素", [arr count]);
//    NSLog(@"数组下标越界：%@", arr[3]);
    /**
     'NSRangeException', reason: '*** -[__NSArrayI objectAtIndex:]: index 3 beyond bounds [0 .. 2]'
     */
    
    //第二种创建数组的方式：
    NSArray *dateList2 = [NSArray arrayWithObjects:yesterday, now, tomorrow, nil];
    
    //遍历
    NSUInteger arrCount = [arr count];
    for (int i = 0; i < arrCount; ++i) {
        NSDate *tmpDate = arr[i];
        NSLog(@"arr[%d]=%@", i, tmpDate);
    }
    
    //第二种遍历方法
    for (NSDate *date in arr) {
        NSLog(@"=======%@", date);
    }
    
    //NSMutableArray可变数组，可删除更改内容及index
    NSMutableArray *mtArr = [NSMutableArray array];
    [mtArr addObject:now];
    [mtArr addObject:tomorrow];
    [mtArr insertObject:yesterday atIndex:0];
    for (NSDate *date in mtArr) {
        NSLog(@"==mtarray===%@", date);
    }
    [mtArr removeObjectAtIndex:0];
    NSLog(@"mtarr[0]=%@", mtArr[0]);
}

void homework17() {
    NSMutableArray *mArr = [NSMutableArray array];
    [mArr addObject:@"leiming32"];
    [mArr addObject:@"xiaohua"];
    [mArr addObject:@"xiaofang"];
    for (NSString *s in mArr) {
        NSLog(@"name: %@", s);
    }
    
    NSString *file1 = @"/usr/share/dict/propernames";
    NSString *file2 = @"/usr/share/dict/words";
    NSString *nameString1 = [NSString stringWithContentsOfFile:file1 encoding:NSUTF8StringEncoding error:NULL];
    NSString *nameString2 = [NSString stringWithContentsOfFile:file2 encoding:NSUTF8StringEncoding error:NULL];
    NSArray *names1 = [nameString1 componentsSeparatedByString:@"\n"];
    NSArray *names2 = [nameString2 componentsSeparatedByString:@"\n"];
    for (NSString *n in names1) {
        NSLog(@"names1: %@", n);
    }
    for (NSString *n in names2) {
        NSLog(@"names2: %@", n);
    }
    for (NSString *n in names1) {
        for (NSString *n2 in names2) {
            if ([n isEqualToString:n2]) {
                NSLog(@"find one! %@", n);
            }
        }
        
//        NSRange r = [n rangeOfString:@"AA" options:NSCaseInsensitiveSearch];
//        if (r.location != NSNotFound) {
//            NSLog(@"find %@", n);
//        }
    }
}

void study18() {
    BNRPerson *p1 = [[BNRPerson alloc] init];
    [p1 setWeightInKilos:96];
    [p1 setHeightInMeters:1.8];
    
    float h = [p1 heightInMeters];
    int w = [p1 weightInKilos];
    
    NSLog(@"h=%.2f, w=%d, BMI:%.2f", h, w, [p1 bodyMassIndex]);
}

//属性property   .方法调用
void study19() {
    BNRStockHolding *h1 = [[BNRStockHolding alloc] init];
    BNRStockHolding *h2 = [[BNRStockHolding alloc] init];
    
    h1.buyPrice = 10;
    h1.currentPrice = 20;
    h1.num = 5;
    
    h2.buyPrice = 100;
    h2.currentPrice = 200;
    h2.num = 50;
    
    NSArray *arr = @[h1, h2];
    for (BNRStockHolding *h in arr) {
        NSLog(@"h cost:%.2f, h value:%.2f", [h costInDollars], [h valueInDollars]);
    }
}

//继承 BNREmployee   导入BNREmployee.h
void study20() {
    BNREmployee *mike = [[BNREmployee alloc] init];
    
    mike.weightInKilos = 96;
    mike.heightInMeters = 1.9;
    mike.employeeID = 112;
//    unsigned int code = mike.officeAlarmCode;
//
    mike.hireDate = [NSDate dateWithNaturalLanguageString:@"Aug 2nd, 2010"];
    
    NSLog(@"mike:%@ h=%.2f, w=%d, BMI:%.2f hireDate:%@, years:%.2f", mike, mike.heightInMeters, mike.weightInKilos,
          [mike bodyMassIndex],mike.hireDate, [mike yearsOfEmployment]);
}

//对象实例变量及属性 一个empoyee中有一个_assets数组，里面存放一些NSAsset
void study21() {
    NSMutableArray *employees = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; ++i) {
        BNREmployee *em = [[BNREmployee alloc] init];
        em.weightInKilos = 90 + i;
        em.heightInMeters = 1.8 - i / 10.0;
        em.employeeID = i;
        [employees addObject:em];
    }
    NSMutableArray *assetArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 10; ++i) {
        BNRAsset *asset = [[BNRAsset alloc] init];
        NSString *label = [NSString stringWithFormat:@"label:%d", i];
        asset.label = label;
        asset.resaleValue = i + 10;
        
        //取随机数
        NSUInteger randomIndex = random() % [employees count];
        
        BNREmployee *em = [employees objectAtIndex:randomIndex];
        
        [em addAsset:asset];
        [assetArray addObject: asset];
    }
    NSLog(@"employees:%@", employees);
    NSLog(@"assetArray:%@", assetArray);
    
    NSLog(@"============>give up index5");
    [employees removeObjectAtIndex:5];
    NSLog(@"assetArray:%@", assetArray);
    
    NSLog(@"===========>give up employees");
    employees = nil;
}

//弱引用
void study23() {
    //BNRAssset.h中weak引用 
    
    __weak BNRPerson *weakPreson;//显示声明为弱引用
}

//collection
void study24() {
    //NSSet  containsObject查找是否存在很快！  调用isEqual来比较
    
    //NSDictionary
    
    NSMutableArray *employees = [[NSMutableArray alloc] init];
    NSMutableDictionary *exes = [[NSMutableDictionary alloc] init];
    
    for (int i = 0; i < 10; i++) {
        BNREmployee *em = [[BNREmployee alloc] init];
//        em.weightInKilos = 90 + i;
//        em.heightInMeters = 1.8 - i / 10.0;
//        em.employeeID = i;
        if (i < 5) {
            [em setWeightInKilos:90 + i];
        } else if (i == 6) {
            [em setWeightInKilos:90];
        } else {
            [em setWeightInKilos:90 - 2 * i];
        }
        
        [em setHeightInMeters:1.8 - i / 10.0];
        [em setEmployeeID:i];
        
        [employees addObject:em];
        
        if (i == 0) {
            [exes setObject:em forKey:@"CEO"];
        }
        if (i == 1) {
            [exes setObject:em forKey:@"CTO"];
        }
    }
    
    NSLog(@"executives: %@", exes);
    NSLog(@"ceo: %@", exes[@"CTO"]);
    exes = nil;
    
    NSDictionary *dict = @{
                           @"AA":   @[],//和[NSArray array]相等
                           @"BB":   @[@"VALUE_BB"],
                           @"CC":   @[@"VALUE_C1", @"VALUE_C2"],
                           @"DD":   @123 // NSNumber
                           };
    NSLog(@"dict: %@", dict);
    NSLog(@"dd:%@", dict[@"DD"]);
    dict = nil;
    
    //对于NSSet NSArray等不可修改对象，copy方法只是返回自己的指针。而可修改对象就要制作一个新的拷贝，并返回它的指针。
    //NSArray,NSString,NSData,NSCharactoerSet,NSSet,NSDictionary,NSIndexSet,NSURLRquest,NSAttributedString
    
    //数组排序
    NSLog(@"排序前：%@", employees);
    NSSortDescriptor *desWeight = [NSSortDescriptor sortDescriptorWithKey:@"weightInKilos" ascending:TRUE];
    NSSortDescriptor *desId = [NSSortDescriptor sortDescriptorWithKey:@"employeeID" ascending:FALSE];
    [employees sortUsingDescriptors: @[desWeight, desId]];
    NSLog(@"排序后：%@", employees);
    
    //过滤
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"weightInKilos > 91"];
    NSArray *predArray = [employees filteredArrayUsingPredicate:pred];
    NSLog(@"predArray:%@", predArray);
    predArray = nil;
    
    //collection只能保存对象，float,int及指向结构的指针要先封装成对象
    NSMutableArray *list = [[NSMutableArray alloc] init];
    [list addObject:@12];
    [list addObject:@5.6];//封装成NSNumber
    
    NSLog(@"list[1]:%@", list[1]);
    NSNumber *num = list[1];//NSNumber不能直接计算，要先将值取出来计算
    float f = [num floatValue];
    [list addObject: [NSNumber numberWithFloat:f + 12]]; //计算后，再装入list
    NSLog(@"list: %@", list);
    
    NSPoint somePoint = NSMakePoint(10, 20);
    NSValue *pointValue = [NSValue valueWithPoint:somePoint];
    [list addObject:pointValue];//对于指向结构的指针，要先封闭成NSValue再装入list中
    
    [list addObject:[NSNull null]];//加入一个空。 不能加入nil
    NSLog(@"after add null, list:%@", list);
}

//常量
void study25() {
    NSLog(@"M_PI:%f", M_PI);//math.h
    
    //全局变量NSLocaleCurrencyCode
    NSLocale *here = [NSLocale currentLocale];
    NSString *currency = [here objectForKey:NSLocaleCurrencyCode];
    NSLog(@"currency: %@", currency);
    
    //enum
    enum Speed{
        S1 = 1,
        S2 = 2,
        S3 = 3
    };

    //一种快捷方式   ----typedef 不要在方法中使用typedef，要在.m文件的顶部，或者.h文件中使用
    typedef enum {
        S21 = 11,
        S22 = 12,
        S23 = 13
    } Speed2;

    //去掉值，//值不代表啥意义，通常只是区别而已
    typedef enum {
        S31,S32,S33
    } Speed3;
    
    //ios6开始加入的
    typedef NS_ENUM(int, Speed4) {
        S41,S42,S43
    };

}

//通过nsstring和nsdata将数据 写入文件
void study26() {
    //通过NSString写文件
    NSMutableString *str = [[NSMutableString alloc] init];
    for (int i = 0; i < 4; ++i) {
        [str appendString:@"leiming32 is good!"];
    }
    
    NSError *error;
    //error引用传递, 传入地址的地址
    BOOL success = [str writeToFile:[NSString stringWithFormat:@"%@/c26/tt.txt", TEST_DIR] atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (success) {
        NSLog(@"DONE WRITING !");
    } else {
        NSLog(@"FAIL WRITING !%@", [error localizedDescription]);
    }

    //通过NSString读文件
    NSError *error2;
    NSString *readStr = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/c26/tt.txt", TEST_DIR] encoding:NSUTF8StringEncoding error:&error2];
    if (!readStr) {
        NSLog(@"read failed! %@", [error2 localizedDescription]);
    } else {
        NSLog(@"read success! %@", readStr);
    }

}

//NSData 代表内存中的缓存区，可保存指定字节数的数据
int study26_NSData_download() {
    //特别目录
    NSArray *dirs = NSSearchPathForDirectoriesInDomains(NSDownloadsDirectory, NSUserDomainMask, YES);
    NSLog(@"DIRS: %@", dirs);
    NSLog(@"dirs[0]:%@", dirs[0]);
//    NSMutableString *path = dirs[0];//NSMutableString不能这么初始化
    NSMutableString *path = [NSMutableString stringWithString:dirs[0]];
//    NSString *s = [path appendString:@"bing.jpg"];  //error!!appendString返回的是void
    [path appendString:@"/bing.jpg"];
    NSLog(@"path: %@", path);
    
    //ok too!
    NSString *path2 = [NSString stringWithFormat:@"%@/bing.jpg", dirs[0]];
    NSLog(@"path2: %@", path);
    
    NSString *path3 = [NSString stringWithFormat:@"%@/c26/bing.jpg", TEST_DIR];
    NSLog(@"path3: %@", path3);
    
    //下载并保存图片
    NSURL *url = [NSURL URLWithString:@"http://b.hiphotos.baidu.com/zhidao/pic/item/1f178a82b9014a90e7eb9d17ac773912b21bee47.jpg"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:&error];
    if (!data) {
        NSLog(@"ftech failed! %@", [error localizedDescription]);
        return 1;
    }
    
    NSLog(@"the file is %lu bytes", (unsigned long)[data length]);
    //    //NSDataWritingAtomic表示原子操作，保证文件完整性。先写入临时文件，成功后再移动至指定位置。要么是完整的文件，要么就没有。断电等情况发生，不会存在半个残缺的下载文件。
//    BOOL writeRet = [data writeToFile:@"/Users/leiming32/ios/fortest/c26/bing.jpg" options:NSDataWritingAtomic error:&error];
    BOOL writeRet = [data writeToFile:path3 options:NSDataWritingAtomic error:&error];
    if (!writeRet) {
        NSLog(@"write failed: %@", [error localizedDescription]);
        return 1;
    }
    
    NSLog(@"download success!");
    
    //读入NSData对象
    NSData *readData = [NSData dataWithContentsOfFile:path3];
    NSLog(@"readdata bytes:%lu", (unsigned long)[readData length]);
    
    return 0;
}

//回调
void study27() {
    BNRLogger *loger = [[BNRLogger alloc] init];
    
    //将loger注册为观察者，监听时钟变化 NSSystemTimeZoneDidChangeNotification. 注意@selector后面括号，带参数所以，里面方法名后面有冒号！
    [[NSNotificationCenter defaultCenter] addObserver:loger selector:@selector(zoneChange:) name:NSSystemTimeZoneDidChangeNotification object:nil];
    
//    NSURL *url = [NSURL URLWithString:@"http://www.hzqx.com/hztq/data/dlyb.json"];
    NSURL *url = [NSURL URLWithString:@"http://d.hiphotos.baidu.com/zhidao/pic/item/a686c9177f3e6709bad238c739c79f3df8dc5533.jpg"];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    __unused NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:req delegate:loger startImmediately:YES];
    
    //发送消息给target，每隔两秒执行   NSTimer与nsRunLoop一起使用！
    __unused NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:loger selector:@selector(updateLastTime:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] run];
    
}

//Block  一段代码。匿名函数，函数指针
//它与函数很重要的一个区别，它使用外部的一个指向其他对象的指针时，是强引用！当前block对象释放前，被引用的对象一定不会释放.
void study28() {
    //将数据中的字符串移除无音字母，然后存放在一个新的数组中
    NSArray *orgStrings = @[@"Saguerkrant", @"Raygun", @"Big Nerd Ranch", @"Missisippi"];
    
    NSLog(@"orgString:%@", orgStrings);
    
    NSMutableArray *retStrings = [NSMutableArray array];
    
    //元音字母
    NSArray *vowels = @[@"a", @"e", @"i", @"o", @"u"];
    
    //声明block变量   这句声明可以与下面的赋值连成一句的.
    void (^devowelizer)(id, NSUInteger, BOOL *);
    
    //实现block变量
    devowelizer = ^(id string, NSUInteger i, BOOL *stop) {//注意NSUInteger，而不是NSInteger. 中间字母U
        NSRange bRange = [string rangeOfString:@"b" options:NSCaseInsensitiveSearch];//找到b的单词就结束
        if (bRange.location != NSNotFound) {
            *stop = YES; //执行完当前block对象后停止
            return;
        }
        
        //id类型：无论数组里什么对象，都可以把元素地址给id类型。id是一个指针。
        NSMutableString *newString = [NSMutableString stringWithString:string];
        
        for (NSString *s in vowels) {
            NSRange fullRange = NSMakeRange(0, [newString length]);//搜索范围
            [newString replaceOccurrencesOfString:s withString:@"" options:NSCaseInsensitiveSearch range:fullRange];
        }
        [retStrings addObject:newString];
    };
    
    [orgStrings enumerateObjectsUsingBlock:devowelizer];
    
    NSLog(@"retStrings:%@", retStrings);
    
    //带返回值的block
    double (^divBlock)(double, double) = ^(double d1, double d2) {
        double ret = d1 / d2;
        return ret;
    };
    NSLog(@"divBlock test : %f", divBlock(2.3, 1.8));
    
    //外部变量
    /**
     block使用外部变量 ，为了保证在使用的时候外部变量还存在，就要捕获这些变量capture
     对于基本类型，就是值拷贝
     对于指针类型，block就会强引用. 直到block对象释放. 而函数无法做到这一点，这是block和函数区别非常非常重要的一点!
     */
    
    //使用self
    /**
     void (^myBlock)();类的一个属性
     
     myBlock = ^{
        NSLog(@"myseft:%@", self); //造成强引用循环。 由于block生命周期很长，一直被当前对象抓着。而block也抓着self
     };
     
     为了避免上面的情况，要先声明一个弱引用
     __weak BNREmployee *weakSelf = self;//employee对象持有block对象的弱引用 .
     myBlock = ^{
//         NSLog(@"myseft:%@", weakSelf); //由于employee对象持有block对象的弱引用 ，在block对象执行的时候很有可能被释放了.
     
        //为了避免上面的情兑发生，在block对象中创建一个innerSelf，对self的局部强引用
        BNREmployee *innerSelf = weakSelf;//局部强引用 局部强引用循环只在block执行的内部生成，执行完成后循环就消失了.
        NSLog(@"innerSeft:%@", innerSelf);
        
        NSLog(@"employid:@d", _employeeId);//无意中使用了self->employeeId
        NSLog(@"employid:@d", innerSelf.employeeId); //应该使用存取方法，避免无意使用self
     
     
     };
     */
    
    //修改外部变量
    __block int count = 1; //不加__block是不能修改的，因为被捕获的变量是常数
    void (^counter)() = ^{ count++; };
    
    counter();
    counter();
    NSLog(@"count:%d", count);
}

//匿名传递block
void homework28_1() {
    //将数据中的字符串移除无音字母，然后存放在一个新的数组中
    NSArray *orgStrings = @[@"Saguerkrant", @"Raygun", @"Big Nerd Ranch", @"Missisippi"];
    
    NSLog(@"orgString:%@", orgStrings);
    
    NSMutableArray *retStrings = [NSMutableArray array];
    
    //元音字母
    NSArray *vowels = @[@"a", @"e", @"i", @"o", @"u"];
    
    //声明block变量   这句声明可以与下面的赋值连成一句的.
//    void (^devowelizer)(id, NSUInteger, BOOL *);
    
    [orgStrings enumerateObjectsUsingBlock:^(id string, NSUInteger i, BOOL *stop) {//注意NSUInteger，而不是NSInteger. 中间字母U
        NSRange bRange = [string rangeOfString:@"b" options:NSCaseInsensitiveSearch];//找到b的单词就结束
        if (bRange.location != NSNotFound) {
            *stop = YES; //执行完当前block对象后停止
            return;
        }
        
        //id类型：无论数组里什么对象，都可以把元素地址给id类型。id是一个指针。
        NSMutableString *newString = [NSMutableString stringWithString:string];
        
        for (NSString *s in vowels) {
            NSRange fullRange = NSMakeRange(0, [newString length]);//搜索范围
            [newString replaceOccurrencesOfString:s withString:@"" options:NSCaseInsensitiveSearch range:fullRange];
        }
        [retStrings addObject:newString];
    }];
    
    NSLog(@"retStrings:%@", retStrings);
}

//将27章中的
void homework28_2() {
    NSLog(@"homework28_2.........");
    
//        BNRLogger *loger = [[BNRLogger alloc] init];
//    [[NSNotificationCenter defaultCenter] addObserver:loger selector:@selector(zoneChange:) name:NSSystemTimeZoneDidChangeNotification object:nil];

    //改为
    [[NSNotificationCenter defaultCenter] addObserverForName:NSSystemTimeZoneDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
            NSLog(@"the system time zone has changeed! %@", note);
    }];
    
    [[NSRunLoop currentRunLoop] run];//更改时区的，这里必须loop着，监听不到回调
}
    
//协议，java中的接口
void study29() {
//    @interface MyController : UIViewController<UITableViewDataSource>   //继承与协议（接口）
    
//    respondsToSelector   调用协议的可选方法，先判断
}

//propertylist  写入和读取
void study30() {
    NSMutableArray *stocks = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *stock = [NSMutableDictionary dictionary];
    
    [stock setObject:[NSNumber numberWithInt:100] forKey:@"shares"];
    [stock setObject:@"GOOG" forKey:@"symbol"];
    [stocks addObject:stock];
    
    stock = [NSMutableDictionary dictionary];
    [stock setObject:[NSNumber numberWithInt:200] forKey:@"shares"];
    [stock setObject:@"BABA" forKey:@"symbol"];
    [stocks addObject:stock];
    
    NSString *path = [NSString stringWithFormat:@"%@/c30/stock.plist", TEST_DIR];
    NSLog(@"path:%@", path);
    
    [stocks writeToFile:path atomically:YES];//path路径必须存在，不会自动新建文件夹！只会新建文件！
    
    NSArray *stockList = [NSArray arrayWithContentsOfFile:path];
    for (NSDictionary *d in stockList) {
        NSLog(@"i have %@ shares of %@", [d objectForKey:@"shares"], [d objectForKey:@"symbol"]);
    }
}

void testString() {
    NSString *someText = @"https://h5.waptest.taobao.com/";
    NSString *ret = [someText stringByReplacingOccurrencesOfString:@"https" withString:@"http"];
    NSLog(@"ret:%@", ret);
    
    NSString *tag = @"bizOrderId=";
    NSString *url = @"http://huodong.m.taobao.com/buy/paySuccess.html?bizOrderId=3043595431335404&degrade=0&act=false";
    
    NSRange wenRange = [url rangeOfString:@"?"];
    NSLog(@"wenRange:%@", NSStringFromRange(wenRange));
    NSLog(@"substr substringToIndex:%@", [url substringToIndex:wenRange.location]);//不包含tolocation位置那个字符
    
    NSRange range = [url rangeOfString:tag options:NSCaseInsensitiveSearch];
    NSLog(@"range:%@", NSStringFromRange(range));
    range.location = range.location + range.length;
    range.length = [url length] - range.location;
    NSLog(@"new range:%@", NSStringFromRange(range));
    NSString *subStr = [url substringWithRange:range];
    NSLog(@"subStr:%@", subStr);
    
    if (subStr.length > 0) {
        NSRange range2 = [subStr rangeOfString:@"&"];
        if (range2.length > 0) {
            range2.length = range2.location;
            range2.location = 0;
            subStr = [subStr substringWithRange:range2];
            NSLog(@"subStr:%@", subStr);
        }
    }
    
    NSArray *array = @[@"aa", @"bb"];
    NSLog(@"contains:%d", [array containsObject:@"bb"]);
    
//    NSRange range = NSMakeRange(0,1);
//    NSString *newText = [someText stringByReplacingCharactersInRange:range withString:@"B"];
}

void testCopy() {
    TestCopy *tcopy = [[TestCopy alloc] init];
    [tcopy testNSStringCopy];
    [tcopy testNSStringCopy2];
    [tcopy testNSArrayCopy];
    [tcopy testNSArrayCopy2];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"HELLO_WORLD:%@", HELLO_WORLD);//常量，不是define定义的，而是全局变量
        
//        study13();
//        homework13();
//        
//        study14();
//        homework14();
//        
//        study15();
        
//        study16();
        
//        study17();
//        homework17();
        
//        study18();
//        study19();
        
//        study20();
//        study21();
        
//        study24();
//        study25();
//        study26();
//        return study26_NSData_download();
        study27();
        
//        study28();
//        homework28_1();
//        homework28_2();
        
//        study30();
//        testString();
        
//        testCopy();
        
//        sleep(100);//要查看内存leak，这里sleep
    }
    return 0;
}
