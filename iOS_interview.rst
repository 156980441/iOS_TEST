Interview Questions
===================

笔试题
------

#. UITableViewDelegate 以及 UITableViewDataSource 常用方法有哪些，请列举并且写出相应方法


#. NSURLSession 常用方法有哪些，请列举并且写出相应方法


#. iOS 创建线程的方法都有哪些，请列举并且写出相应方法


#. iOS观察模式的方法都有哪些，请列举并且写出相应方法


#. iOS数据持久化方法都有哪些，请列举并且写出相应方法


#. iOS 的锁都有哪些


#. Extension和Category的区别


#. 曾经做过项目的难解的 bug 是什么，怎么解决的


#. @property([attribute1 , attribute2, ...])修饰符都有哪些，分别有什么作用


#. 下面的代码是否有问题

	.. code-block:: cpp

   	@autoreleasepool {
        for (int i=0; i<largeNumber; i++) {
            Person *per = [[Person alloc] init];
            [per autorelease];
        }
    }


#. 写出下面代码在控制台的打印结果

	.. code-block:: cpp

	let queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL);

	NSLog("之前 - %@", NSThread.currentThread());

	dispatch_async(queue, { () -> Void in
		NSLog("sync之前 - %@", NSThread.currentThread());
		dispatch_sync(queue, { () -> Void in
			NSLog("sync - %@", NSThread.currentThread());
		})
		NSLog("sync之后 - %@", NSThread.currentThread());
	});

	NSLog("之后 - %@", NSThread.currentThread());



#. iOS 点击屏幕时是如何交互的


#. 请使用GCD实现1，2并行和3串行和45串行，4，5是并行。即3依赖1，2的执行，45依赖3的执行


	+----------+--------+----------+
	| 1        |        |     4    |
	+----------+   3    +----------+
	| 2        |        |     5    |
	+----------+--------+----------+


#. protocol 和 category 中如何使用 @property


#. 网络请求的 header 中都有哪些信息


#. 常见网络状态码


#. POST GET 区别


#. HTTP 加密方式以及几次握手


#. HTTPS 交互流程


#. 大文件数据下载


#. float 和 double 的区别


笔试题答案
----------

#. UITableViewDelegate 以及 UITableViewDataSource 常用方法有哪些，请列举并且写出相应方法


	.. code-block:: cpp

		@protocol UITableViewDelegate<NSObject, UIScrollViewDelegate>

		// Variable height support

		- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
		- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
		- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;

		- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
		- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;

		- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

		@protocol UITableViewDataSource<NSObject>

		@required

		- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
		- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

		@optional

		- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
		- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
		- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;


#. NSURLSession 常用方法有哪些，请列举并且写出相应方法


	.. code-block:: cpp

		+ (NSURLSession *)sessionWithConfiguration:(NSURLSessionConfiguration *)configuration;
		+ (NSURLSession *)sessionWithConfiguration:(NSURLSessionConfiguration *)configuration delegate:(nullable id <NSURLSessionDelegate>)delegate delegateQueue:(nullable NSOperationQueue *)queue;

		- (void)finishTasksAndInvalidate;
		- (void)getTasksWithCompletionHandler:(void (^)(NSArray<NSURLSessionDataTask *> *dataTasks, NSArray<NSURLSessionUploadTask *> *uploadTasks, NSArray<NSURLSessionDownloadTask *> *downloadTasks))completionHandler;

		- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request;
		- (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url;
		- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request fromFile:(NSURL *)fileURL;
		- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request fromData:(NSData *)bodyData;


#. iOS 创建线程的方法都有哪些，请列举并且写出相应方法


	Pthreads;NSThread;GCD;NSOperation & NSOperationQueue

	.. code-block:: cpp

		- (void)viewDidLoad {
			[super viewDidLoad];
			pthread_t thread;
			//创建一个线程并自动执行
			pthread_create(&thread, NULL, start, NULL);
		}

		void *start(void *data) {
			NSLog(@"%@", [NSThread currentThread]);
			return NULL;
		}

		NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run:) object:nil];
		[thread start];

		[NSThread detachNewThreadSelector:@selector(run:) toTarget:self withObject:nil];

		[self performSelectorInBackground:@selector(run:) withObject:nil];

		dispatch_queue_t queue = dispatch_queue_create("tk.bourne.testQueue", DISPATCH_QUEUE_SERIAL);
		dispatch_queue_t queue = dispatch_queue_create("tk.bourne.testQueue", DISPATCH_QUEUE_CONCURRENT);

		dispatch_queue_t queue = ispatch_get_main_queue();
		dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

		dispatch_sync(<#queue#>, ^{
			//code here
			NSLog(@"%@", [NSThread currentThread]);
		});

		NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
		[operation start];

		NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
			NSLog(@"%@", [NSThread currentThread]);
		}];
		[operation start];

		NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
			NSLog(@"%@", [NSThread currentThread]);
		}];

		for (NSInteger i = 0; i < 5; i++) {
			[operation addExecutionBlock:^{
				NSLog(@"第%ld次：%@", i, [NSThread currentThread]);
			}];
		}

		[operation start];


		NSOperationQueue *queue = [[NSOperationQueue alloc] init];


		NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
			NSLog(@"%@", [NSThread currentThread]);
		}];


		for (NSInteger i = 0; i < 5; i++) {
			[operation addExecutionBlock:^{
				NSLog(@"第%ld次：%@", i, [NSThread currentThread]);
			}];
		}

		[queue addOperation:operation];


#. iOS观察模式的方法都有哪些，请列举并且写出相应方法

	KVO的全称是Key-Value Observer，即键值观察。
	NSNotificationCenter

#. iOS数据持久化方法都有哪些，请列举并且写出相应方法

	属性列表、对象归档、SQLite3和Core Data

	.. code-block:: cpp

		[NSUserDefaults standardUserDefaults]

		- (void) initWithCoder:(NSCoder *)encoder
		- (void) encodeWithCoder:(NSCoder *)encoder


#. iOS 的锁都有哪些

	NSLock

	@synchronized

	dispatch的semaphore

	条件锁NSCondition

	条件锁NSConditionLock

	NSDistributedLock

	互斥锁POSIX

	自旋锁OSSpinLock

#. Extension和Category的区别

	- Category可以写在单独一个文件内，也可以写在与之关联的类里面
	- Extension必须写在实现文件.m里
	- Category声明的方法可以不实现.
	- Extension里声明的方法必须实现
	- Category不能添加实例变量
	- Extension可以添加实例变量
	- Category是运行时才会执行
	- Extension是编译时就会和关联的类一起编译

#. 曾经做过项目的难解的 bug 是什么，怎么解决的

	- 多线程访问全局 static 变量，在使用 strcat 的时候，data_full_path 的长度大于了 full_path

	.. code-block:: cpp

		NSInteger len = strlen(data_full_path);
		char* full_path = (char*)malloc(len + 1);
		strcat(full_path, data_full_path);

	- 引擎子线程想传递参数给主线程，并在主线程执行一些列函数

	.. code-block:: cpp

		dispatch_sync(dispatch_get_main_queue(), ^{
			func(params);
		});

	存在 bug : As an optimization, this function invokes the block on the current thread when possible.
	使用 : [self performSelectorOnMainThread:@selector(performInMainThread1Params) withObject:nil waitUntilDone:YES];

	.. code-block:: cpp
		dispatch_async(QueueA, ^{
			someFunctionA(...);
			dispatch_sync(QueueB, ^{
				someFunctionB(...);
			});
		});

	When QueueA runs the block, it will temporarily own a thread, any thread. someFunctionA(...) will execute on that thread. Now while doing the synchronous dispatch, QueueA cannot do anything else, it has to wait for the dispatch to finish. QueueB on the other hand, will also need a thread to run its block and execute someFunctionB(...). So either QueueA temporarily suspends its thread and QueueB uses some other thread to run the block or QueueA hands its thread over to QueueB (after all it won't need it anyway until the synchronous dispatch has finished) and QueueB directly uses the current thread of QueueA.

	Needless to say that the last option is much faster as no thread switch is required. And this is the optimization the sentence talks about. So a dispatch_sync() to a different queue may not always cause a thread switch (different queue, maybe same thread).

	But a dispatch_sync() still cannot happen to the same queue (same thread, yes, same queue, no). That's because a queue will execute block after block and when it currently executes a block, it won't execute another one until this one is done. So it executes BlockA and BlockA does a dispatch_sync() of BlockB on the same queue. The queue won't run BlockB as long as it still runs BlockA, but running BlockA won't continue until BlockB has ran. See the problem?

	https://stackoverflow.com/questions/10984732/why-cant-we-use-a-dispatch-sync-on-the-current-queue

	- 三方库的冲突，比如一些老的 SDK 使用了老版本的 sqlite， 头文件的不一致

	- 32bit 转换 64bit 的指针问题，比如老的 SDK 在 64bit 下就不需要对 double 保护，但在 32bit 下就需要。

	- 版本迭代过程中的错误，根本原因是在新需求设计上的 bug，引擎先传入 userdata 目录让 SDK 补全路径，SDK 先在可读可写目录建立，之后传入 userdata/app.cfg，却在 bundle 下，该目录只读，但找到 app.cfg 后代码同时创建了数据库，返回了 NULL 数据库指针。在启动后加载地图缓存子线程写入数据库时用到了该路径，造成崩溃。
	解决方式：在 bundle 中创建 appdata/app.cfg 文件，传入 appdata/app.cfg 在 bundle 只读，在 可读可写的 doc/userdata 创建数据库。

	- 显存泄露，忘记 glDeleteFramebuffers(1, &_defaultFramebuffer);



#. @property([attribute1 , attribute2, ...])修饰符都有哪些，分别有什么作用

	copy，assign（默认），retain，strong（默认），weak（自动nil），readwrite（默认），readonly，unsafe_unretained（NSFont即Mac开发下，等同于assign）在iOS 9之后，nonnull ,nullable,null_resettable（get不能返回为空, set可以为空）,_Null_unspecified（不确定是否为空）

#. 下面的代码是否有问题

	.. code-block:: cpp

		@autoreleasepool {
			for (int i=0; i<largeNumber; i++) {
				Person *per = [[Person alloc] init];
				[per autorelease];
			}
		}


	在循环里套一层autoreleasepool，这样每循环一次都会释放掉在循环里创建的对象。不加的话得被创建的对象需要在循环完才会释放掉，如果循环次数太大的话会造成大量内存占用。

#. 写出下面代码在控制台的打印结果

	.. code-block:: cpp

		let queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL);

		NSLog("之前 - %@", NSThread.currentThread());

		dispatch_async(queue, { () -> Void in
			NSLog("sync之前 - %@", NSThread.currentThread());
			dispatch_sync(queue, { () -> Void in
				NSLog("sync - %@", NSThread.currentThread());
			})
			NSLog("sync之后 - %@", NSThread.currentThread());
		});

		NSLog("之后 - %@", NSThread.currentThread());

	之前 - <NSThread: 0x7fe32050dbb0>{number = 1, name = main}
	sync之前 - <NSThread: 0x7fe32062e9f0>{number = 2, name = (null)}
	之后 - <NSThread: 0x7fe32050dbb0>{number = 1, name = main}

	后两者顺序随机，关键是不会打印出 sync 以及 sync 之后输出。


#. iOS 点击屏幕时是如何交互的

	- 传递链：由系统向离用户最近的view传递。UIKit –> active app’s event queue –> window –> root view –>……–>lowest view
	- 响应链：由离用户最近的view向系统传递。initial view –> super view –> …..–> view controller –> window –> Application


#. 请使用GCD实现1，2并行和3串行和45串行，4，5是并行。即3依赖1，2的执行，45依赖3的执行

	+----------+--------+----------+
	| 1        |        |     4    |
	+----------+   3    +----------+
	| 2        |        |     5    |
	+----------+--------+----------+


	.. code-block:: cpp

		- (void) methodone{

			dispatch_group_t group = dispatch_group_create();

			dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
				NSLog(@"%d",1);
			});

			dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
				NSLog(@"%d",2);
			});

			dispatch_group_notify(group, dispatch_get_main_queue(), ^{
				NSLog(@"3");

				dispatch_group_t group1 = dispatch_group_create();

				dispatch_group_async(group1, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
					NSLog(@"%d",4);
				});

				dispatch_group_async(group1, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
					NSLog(@"%d",5);
				});
			});
		}



#. @protocol 和 category 中如何使用 @property

	- 在protocol中使用property只会生成setter和getter方法声明,我们使用属性的目的,是希望遵守我协议的对象能实现该属性
	- category 使用 @property 也是只会生成setter和getter方法的声明
	- 如果我们真的需要给category增加属性的实现,需要借助于运行时的两个函数：objc_setAssociatedObject和objc_getAssociatedObject

#. 网络请求的 header 中都有哪些信息

	- 请求行：包含了请求方法、请求资源路径、HTTP协议版本

	- GET /MJServer/resources/images/1.jpg HTTP/1.1

	- 请求头：包含了对客户端的环境描述、客户端请求的主机地址等信息

	- Host: 192.168.1.105:8080 // 客户端想访问的服务器主机地址

	- User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9) Firefox/30.0// 客户端的类型，客户端的软件环境

	- Accept: text/html, */*// 客户端所能接收的数据类型

	- Accept-Language: zh-cn // 客户端的语言环境

	- Accept-Encoding: gzip // 客户端支持的数据压缩格式

	- 请求体：客户端发给服务器的具体数据，比如文件数据

	- HTTP协议规定：1个完整的HTTP响应中包含以下内容：

	- 状态行：包含了HTTP协议版本、状态码、状态英文名称

	- HTTP/1.1 200 OK

	- 响应头：包含了对服务器的描述、对返回数据的描述

	- Server: Apache-Coyote/1.1 // 服务器的类型

	- Content-Type: image/jpeg // 返回数据的类型

	- Content-Length: 56811 // 返回数据的长度

	- Date: Mon, 23 Jun 2014 12:54:52 GMT // 响应的时间

	- 实体内容：服务器返回给客户端的具体数据，比如文件数据

#. 常见网络状态码

	200 成功
	400 请求错误
	404 找不到
	500 服务器原因

#. POST GET 区别

	GET

	在请求URL后面以?的形式跟上发给服务器的参数，多个参数之间用&隔开，比如http://ww.test.com/login?username=123&pwd=234&type=JSON
	注意：由于浏览器和服务器对URL长度有限制，因此在URL后面附带的参数是有限制的，通常不能超过1KB

	POST

	发给服务器的参数全部放在请求体中
	理论上，POST传递的数据量没有限制（具体还得看服务器的处理能力）

	选择GET和POST的建议

	- 如果要传递大量数据，比如文件上传，只能用POST请求
	- GET的安全性比POST要差些，如果包含机密\敏感信息，建议用POST
	- 如果仅仅是索取数据（数据查询），建议使用GET
	- 如果是增加、修改、删除数据，建议使用POST

#. HTTP 加密方式以及几次握手

	对称加密，非对称加密，单项加密。

#. HTTPS 交互流程

	- 客户端发起HTTPS请求，然后连接到server的443端口。
	- 服务端的配置，采用HTTPS协议的服务器必须要有一套数字证书，可以自己制作，也可以向组织申请。这套证书其实就是一对公钥和私钥。（如果对公钥和私钥不太理解，可以想象成一把钥匙和一个锁头，只是全世界只有你一个人有这把钥匙，你可以把锁头给别人，别人可以用这个锁把重要的东西锁起来，然后发给你，因为只有你一个人有这把钥匙，所以只有你才能看到被这把锁锁起来的东西。）
	- 传送证书，这个证书其实就是公钥，只是包含了很多信息，如证书的颁发机构，过期时间等等。
	- 客户端解析证书，这部分工作是有客户端的TLS来完成的，首先会验证公钥是否有效，比如颁发机构，过期时间等等，如果发现异常，则会弹出一个警告框，提示证书存在问题。如果证书没有问题，那么就生成一个随即值。然后用证书对该随机值进行加密。就好像上面说的，把随机值用锁头锁起来，这样除非有钥匙，不然看不到被锁住的内容。
	- 传送加密信息，这部分传送的是用证书加密后的随机值，目的就是让服务端得到这个随机值，以后客户端和服务端的通信就可以通过这个随机值来进行加密解密了。
	- 服务段解密信息，服务端用私钥解密后，得到了客户端传过来的随机值(私钥)，然后把内容通过该值进行对称加密。所谓对称加密就是，将信息和私钥通过某种算法混合在一起，这样除非知道私钥，不然无法获取内容，而正好客户端和服务端都知道这个私钥，所以只要加密算法够彪悍，私钥够复杂，数据就够安全。
	- 传输加密后的信息，这部分信息是服务段用私钥加密后的信息，可以在客户端被还原
	- 客户端解密信息，客户端用之前生成的私钥解密服务段传过来的信息，于是获取了解密后的内容。整个过程第三方即使监听到了数据，也束手无策。

	#. 大文件数据下载

		- 请求服务器知道文件大小，比如2G
		- 在本地 temp 目录下开辟空间2G
		- 打开 10 个线程下载，每个下载 2G / 10 的数据
		- 下载完之后根据偏移量拼接在一起
		- 校验下载数据完整性，比较大小
		- 有效性，服务端提供的 MD5 编码，本地下载完之后编码比较
		- 下载完成之后移动到目标文件夹
		- 支持断点续传，服务端告诉我上一次下载的位置
		- 过程中联网状态的判断
		- 网速的判断，比如网速很好，一次能给我 10M 的数据，但是客户端内存很小，我们控制一次最多拿 2M,写满 2M 停，开始写入文件，边写入文件，边接受，时刻2M状态
		- 分流处理，防止多个客户端同时访问服务器资源
		- 手机端对于内存的控制，得到的数据就写入到文件

#. float 和 double 的区别

c 和 c++ 对有效数位的要求是，float至少32位，double至少48位且不少于float，long double至少和double一样多（这里指的是二进制数）。
通常来说，float为32位，double为64位，long double为80、96、128位。
大多数情况下，编译器为float分配4字节，double则分配8字节。

float32位组成：最高位的1位为符号位，接着指数位共8位，指数范围-127~+128（补码形式），然后尾数位共23位。
那为什么float型计算机的显示结果只显示6位有效数字呢？
那是因为，计算机内部以二进制法存储数据，尾数23即共2^23个有效数字，那么转化成十进制就是log10（2^23）= 6.92，即6~7位有效数字，计算机保证至少6位有效数字的精度。
同理，64位数的double1位符号位，11位指数位，指数范围为-1023~+1024，52位尾数，有效数字为15~16，保证有效数字为15位精度。
