//
//  ViewController.m
//  KVO_KVC
//
//  Created by fanyunlong on 5/27/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "ViewController.h"

#import "Person.h"
#import "PersonMonitor.h"
#import "AuthorData.h"
#import "BookData.h"


/**
 
 基本的原理：
 
 当观察某对象A时，KVO机制动态创建一个对象A当前类的子类，并为这个新的子类重写了被观察属性keyPath的setter 方法。setter 方法随后负责通知观察对象属性的改变状况。
 
 深入剖析：
 
 Apple 使用了 isa 混写（isa-swizzling）来实现 KVO 。当观察对象A时，KVO机制动态创建一个新的名为： NSKVONotifying_A的新类，该类继承自对象A的本类，且KVO为NSKVONotifying_A重写观察属性的setter 方法，setter 方法会负责在调用原 setter 方法之前和之后，通知所有观察对象属性值的更改情况。
 
 ①NSKVONotifying_A类剖析：在这个过程，被观察对象的 isa 指针从指向原来的A类，被KVO机制修改为指向系统新创建的子类 NSKVONotifying_A类，来实现当前类属性值改变的监听；
 
 所以当我们从应用层面上看来，完全没有意识到有新的类出现，这是系统“隐瞒”了对KVO的底层实现过程，让我们误以为还是原来的类。但是此时如果我们创建一个新的名为“NSKVONotifying_A”的类()，就会发现系统运行到注册KVO的那段代码时程序就崩溃，因为系统在注册监听的时候动态创建了名为NSKVONotifying_A的中间类，并指向这个中间类了。
 
 （isa 指针的作用：每个对象都有isa 指针，指向该对象的类，它告诉 Runtime 系统这个对象的类是什么。所以对象注册为观察者时，isa指针指向新子类，那么这个被观察的对象就神奇地变成新子类的对象（或实例）了。） 因而在该对象上对 setter 的调用就会调用已重写的 setter，从而激活键值通知机制。
 
 —>我猜，这也是KVO回调机制，为什么都俗称KVO技术为黑魔法的原因之一吧：内部神秘、外观简洁。
 
 ②子类setter方法剖析：KVO的键值观察通知依赖于 NSObject 的两个方法:willChangeValueForKey:和 didChangevlueForKey:，在存取数值的前后分别调用2个方法：
 
 被观察属性发生改变之前，willChangeValueForKey:被调用，通知系统该 keyPath 的属性值即将变更；当改变发生后， didChangeValueForKey: 被调用，通知系统该 keyPath 的属性值已经变更；之后， observeValueForKey:ofObject:change:context: 也会被调用。且重写观察属性的setter 方法这种继承方式的注入是在运行时而不是编译时实现的。
 
 KVO为子类的观察者属性重写调用存取方法的工作原理在代码中相当于：
 
 -(void)setName:(NSString *)newName
 {
 [self willChangeValueForKey:@"name"];    //KVO在调用存取方法之前总调用
 [super setValue:newName forKey:@"name"]; //调用父类的存取方法
 [self didChangeValueForKey:@"name"];     //KVO在调用存取方法之后总调用
 }
 
 1.与KVC的不同？
 
 KVC(键值编码)，即Key-Value Coding，一个非正式的Protocol，使用字符串(键)访问一个对象实例变量的机制。而不是通过调用Setter、Getter方法等 显式的存取方式去访问。
 KVO(键值监听)，即Key-Value Observing，它提供一种机制,当指定的对象的属性被修改后,对象就会接受到通知，前提是执行了setter方法、或者使用了 KVC赋值。
 
 2.和notification(通知)的区别？
 
 notification比KVO多了发送通知的一步。
 两者都是一对多，但是对象之间直接的交互，notification明显得多，需要notificationCenter来做为中间交互。而KVO如我们介绍的，设置观察者->处理属性变化，至于中间通知这一环，则隐秘多了，只留一句“交由系统通知”，具体的可参照以上实现过程的剖析。
 
 notification的优点是监听不局限于属性的变化，还可以对多种多样的状态变化进行监听，监听范围广，例如键盘、前后台等系统通知的使用也更显灵活方便。（参照通知机制第五节中系统通知名称内容：）
 
 3.与delegate的不同？
 
 和delegate一样，KVO和NSNotification的作用都是类与类之间的通信。但是与delegate不同的是：
 
 这两个都是负责发送接收通知，剩下的事情由系统处理，所以不用返回值；而delegate 则需要通信的对象通过变量(代理)联系；
 delegate只是一对一，而这两个可以一对多。
 
 4.涉及技术：
 
 KVC/KVO实现的根本是Objective-C的动态性和runtime，以及访问器方法的实现；
 
 
 
 
 
 总结:
 
 对比其他的回调方式，KVO机制的运用的实现，更多的由系统支持，相比notification、delegate等更简洁些，并且能够提供观察属性的最新值以及原始值；但是相应的在创建子类、重写方法等等方面的内存消耗是很巨大的。所以对于两个类之间的通信，我们可以根据实际开发的环境采用不同的方法，使得开发的项目更加简洁实用。
 
 另外需要注意的是，由于这种继承方式的注入是在运行时而不是编译时实现的，如果给定的实例没有观察者，那么KVO不会有任何开销，因为此时根本就没有KVO代码存在。但是即使没有观察者，委托和NSNotification还是得工作，这也是KVO此处零开销观察的优势。
 
**/


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    ////////////////////////////////////////////
    // KVO 测试代码
    ////////////////////////////////////////////
    
    NSLog(@"---------------- KVO ----------------");
    
    // 监视对象
    Person *p = [[Person alloc] init];
    
    // 观察者对象
    PersonMonitor *pm= [[PersonMonitor alloc] init];
    
    //Observer KVO收到通知指定的关键路径相对于接收器。
    /*
     *pm 对象注册KVO通知。观察者必须实现键值观察方法observeValueForKeyPath。
     *forKeyPath 关键路径,相对于接收器,用于观察的属性。这个值不能为零。
     *options NSKeyValueObservingOptions的组合值,指定包含在观察通知的内容。
     *context 任意的数据传递给anObserver在observeValueForKeyPath。
     */
    
    [p addObserver:pm forKeyPath:@"name" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:@"User data"];
    
    // 测试前的数据
    NSLog(@"Before setValue forKey is %@", p.name);
    
    // 通过setvalue 的方法，PersonMonitor的监视将被调用
    [p setValue:@"Happy 1" forKey:@"name"];
    
    // 查看设置后的值
    NSLog(@"After setValue forKey is %@",[p valueForKey:@"name"]);
    
    NSLog(@"Before p.name is %@",p.name);
    
    //效果和通过setValue 是一致的
    p.name = @"Kitty 2";
    
    NSLog(@"After p.name is %@",p.name);
    
    
    NSLog(@"Before changeName is %@",p.name);
    
    //通过person自己的函数来更改 name
    [p changeName];
    
    //最后一次修改是直接修改，所以没法产生通知。只有当我们调用KVC去访问key值的时候KVO才会起作用
    NSLog(@"After changeName is %@",p.name);
    
    //删除观察者
    [p removeObserver:pm forKeyPath:@"name"];
    
    ////////////////////////////////////////////
    ////////////////////////////////////////////
    
    
    ////////////////////////////////////////////
    // KVC 测试代码
    ////////////////////////////////////////////
    
    NSLog(@"---------------- KVC ----------------");
    
    AuthorData * author1 = [[AuthorData alloc] init];
    [author1 setValue:@"tom" forKey:@"name"];
    BookData * book1 = [[BookData alloc] init];
    [book1 setValue:@"english" forKey:@"bookName"];
    [book1 setValue:@"20.0" forKey:@"price"];
    [book1 setValue:author1 forKey:@"author"];
    
    NSLog(@"value=%@",[book1 valueForKey:@"bookName"]);
    NSLog(@"price=%f",[[book1 valueForKey:@"price"] floatValue]);
    NSLog(@"author=%@",[book1 valueForKeyPath:@"author.name"]);//注意这里是Path
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
