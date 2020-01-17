//
//  ViewController.m
//  PrivateTest
//
//  Created by fanyl on 2020/1/17.
//  Copyright © 2020 fanyl. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>
#import "Son.h"

// 为什么说 Objective-C 没有私有方法和私有变量，参考文档：https://www.jianshu.com/p/ef25a31e3112

// 我们声明了两个类，一个 MMFather 类，一个继承自 MMFather 的 MMSon 类。在 MMFather.m 中实现 run: 方法，但是并没有在 MMFather.h 中公开。如果我们直接使用 Son 实例调用 run 方法编译器会报错。

// 其实这跟 Objective-C 语言的动态特性有密切的关系，对象在运行的时候才会去查找方法。Objective-C 对象有一个 isa 指针指向其父类，在向该实例发送消息的时候，若它自己不能识别回到父类中去查找该消息。



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    Son *son = [[Son alloc] init];
    
    // 高版本 Xcode 找不到 objc_msgSend，需要修改 OBJC_OLD_DISPATCH_PROTOTYPES 属性，参考文档：https://www.jianshu.com/p/e5aef096f967
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
           objc_msgSend(son, @selector(run:), @"iPhone");
    #pragma clang diagnostic pop
    
    
    // "-Wundeclared-selector" 是为了消除编译器找不到方法的警告，该方式只能在确认某个方式实现的前提下使用，否者会在运行时奔溃。
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
            if ([son respondsToSelector:@selector(run:)]) {
                [son performSelector:@selector(run:) withObject:@"iPhone"];
            }
    #pragma clang diagnostic pop
    
}


@end
