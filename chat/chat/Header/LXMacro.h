
#define Token @"token"

#define UserID @"userID"

#define Weak(weakSelf)  __weak __typeof(&*self)weakSelf = self;


//常用宏定义
//本地
#define UserDef(ss)  [[NSUserDefaults standardUserDefaults] objectForKey:(ss)]

#define UserDefBool(ss)  [[NSUserDefaults standardUserDefaults] boolForKey:(ss)]

#define UserSetKeyAndValue(value,key) [[NSUserDefaults standardUserDefaults]setObject:value forKey:key]

#define UserSetBoolValueAndKey(value,key) [[NSUserDefaults standardUserDefaults] setBool:value forKey:key]

#define UserDefau   [NSUserDefaults standardUserDefaults]
#define UserDefSyn     [[NSUserDefaults standardUserDefaults] synchronize]

//获取导航栏+状态栏的高度
#define getRectNavAndStatusHight  self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height
//状态栏高度
#define getStatusHight [[UIApplication sharedApplication] statusBarFrame].size.height

//底部tabbar高度
//颜色
//app主色
#define MainColor [UIColor whiteColor]
#define IsFirst @"firstLaunch"
#define IsLogin @"isLogin"


#ifndef yRedColor
#define yRedColor [UIColor redColor]
#endif

#ifndef yGreenColor
#define yGreenColor [UIColor greenColor]
#endif

#ifndef yYellowColor
#define yYellowColor [UIColor yellowColor]
#endif

#ifndef yBlueColor
#define yBlueColor [UIColor blueColor]
#endif

#ifndef yPurpleColor
#define yPurpleColor [UIColor purpleColor]
#endif

#ifndef yOrangeColor
#define yOrangeColor [UIColor orangeColor]
#endif

#ifndef yLightGrayColor
#define yLightGrayColor [UIColor lightGrayColor]
#endif

#ifndef yWhiteColor
#define yWhiteColor [UIColor whiteColor]
#endif

#ifndef yBrownColor
#define yBrownColor [UIColor brownColor]
#endif

#ifndef yCyanColor
#define yCyanColor [UIColor cyanColor]
#endif

#ifndef yClearColor
#define yClearColor [UIColor clearColor]
#endif

#ifndef yBlackColor
#define yBlackColor [UIColor blackColor]
#endif


//屏幕尺寸
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 // 当前Xcode支持iOS8及以上
#define SCREEN_WIDTH ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
#define SCREENH_HEIGHT ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
#define SCREEN_SIZE ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale):[UIScreen mainScreen].bounds.size)
#else
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#endif

//自适应尺寸(以6s尺寸为基准，例如参数中的value值为10 在6s上为10 在Plus上为value/375*Plus的屏幕宽度，此外这个尺寸只以屏幕宽度为准，就算横屏状态下横竖颠倒，依然以短的尺寸为宽度)
#define AUTO_375SIZE(value) (((value)/375.0) * (([UIScreen mainScreen].bounds.size.width > [UIScreen mainScreen].bounds.size.height)?[UIScreen mainScreen].bounds.size.height:[UIScreen mainScreen].bounds.size.width))


//状态栏的高度
#define HitoStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

//导航栏的高度

#define HitoNavBarHeight 44.0

//iphoneX-SafeArea的高度

#define HitoSafeAreaHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?34:0)

//分栏+iphoneX-SafeArea的高度 (tabbar高度)
#define HitoTabBarHeight (49+HitoSafeAreaHeight)

//导航栏+状态栏的高度 （导航栏高度）
#define HitoTopHeight (HitoStatusBarHeight + HitoNavBarHeight)


//获取视图宽高XY等信息
#define HitoviewH(view1) view1.frame.size.height

#define HitoviewW(view1) view1.frame.size.width

#define HitoviewX(view1) view1.frame.origin.x

#define HitoviewY(view1) view1.frame.origin.y

//获取self.view的宽高

#define HitoSelfViewW (self.view.frame.size.width)

#define HitoSelfViewH (self.view.frame.size.height)

///实例化

#define HitoViewAlloc(view,x,y,w,h) [[view alloc]initWithFrame:CGRectMake(x, y, w, h)]

#define HitoAllocInit(Controller,cName) Controller *cName = [[Controller alloc]init]



// 直接判断机型
#ifndef yiPHONE4
#define yiPHONE4 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)480) < DBL_EPSILON)
#endif

#ifndef yiPHONE5
#define yiPHONE5 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON)
#endif

#ifndef yiPHONE6
#define yiPHONE6 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)667) < DBL_EPSILON)
#endif

#ifndef yiPHONE6P
#define yiPHONE6P (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)736) < DBL_EPSILON)
#endif

//是否iphone x
#define yIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//隐藏底部
#define HIDDENBOTTOM - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];if (self) {self.hidesBottomBarWhenPushed=YES;}return self;}

///Log
//#ifdef DEBUG
//#define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
//#else
//#define NSLog(...)
//#endif


//导航栏字体颜色
#define FONTANDCOLOR [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];[self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]}];

/**
 *     便捷定义@property属性
 */


/** copy */

//NSString
#define String_(name) \
    zzn_copy_property(NSString*,name)
//NSArray
#define Array_(name) \
    zzn_copy_property(NSArray*,name)
//NSDictionary
#define Dictionary_(name) \
    zzn_copy_property(NSDictionary*,name)
//NSNumber,它没用对应的不可变类，其实用copy或strong没有区别
#define Number_(name) \
    zzn_copy_property(NSNumber*,name)
//NSData
#define Data_(name) \
    zzn_copy_property(NSData*,name)
//NSSet
#define Set_(name) \
    zzn_copy_property(NSSet*,name)
//NSIndexSet
#define IndexSet_(name) \
    zzn_copy_property(NSIndexSet*,name)

//代码块，名称和传参，没有传参就不填
#define Block_(name,...) \
    zzn_set_block(void,name,__VA_ARGS__)
//有返回值的代码块
#define BlockReturn_(name,returnClass,...) \
    zzn_set_block(returnClass,name,__VA_ARGS__)



/** strong */

//NSMutableString
#define mString_(name,...) \
    zzn_strong_property(NSMutableString*,name,__VA_ARGS__)
//NSMutableArray
#define mArray_(name,...) \
    zzn_strong_property(NSMutableArray*,name,__VA_ARGS__)
//NSMutableDictionary
#define mDictionary_(name,...) \
    zzn_strong_property(NSMutableDictionary*,name,__VA_ARGS__)
//NSMutableData
#define mData_(name,...) \
    zzn_strong_property(NSMutableData*,name,__VA_ARGS__)
//NSMutableSet
#define mSet_(name,...) \
    zzn_strong_property(NSMutableSet*,name,__VA_ARGS__)
//NSMutableIndexSet
#define mIndexSet_(name,...) \
    zzn_strong_property(NSMutableIndexSet*,name,__VA_ARGS__)

//UIImage
#define Image_(name) \
    zzn_strong_property(UIImage*,name)
//UIColor
#define Color_(name) \
    zzn_strong_property(UIColor*,name)
//id
#define id_(name,...) \
    zzn_strong_property(id,name,__VA_ARGS__)

//UIView
#define View_(name,...) \
    zzn_strong_property(UIView*,name,__VA_ARGS__)
//UIImageView
#define ImageView_(name,...) \
    zzn_strong_property(UIImageView*,name,__VA_ARGS__)
//UILabel
#define Label_(name,...) \
    zzn_strong_property(UILabel*,name,__VA_ARGS__)
//UIButton
#define Button_(name,...) \
    zzn_strong_property(UIButton*,name,__VA_ARGS__)
//UITableView
#define TableView_(name,...) \
    zzn_strong_property(UITableView*,name,__VA_ARGS__)
//UICollectionView
#define CollectionView_(name,...) \
    zzn_strong_property(UICollectionView*,name,__VA_ARGS__)
//UISegmentedControl
#define SegmentedControl_(name,...) \
    zzn_strong_property(UISegmentedControl*,name,__VA_ARGS__)
//UITextField
#define TextField_(name,...) \
    zzn_strong_property(UITextField*,name,__VA_ARGS__)
//UISlider
#define Slider_(name,...) \
    zzn_strong_property(UISlider*,name,__VA_ARGS__)
//UISwitch
#define Switch_(name,...) \
    zzn_strong_property(UISwitch*,name,__VA_ARGS__)
//UIActivityIndicatorView
#define ActivityIndicatorView_(name,...) \
    zzn_strong_property(UIActivityIndicatorView*,name,__VA_ARGS__)
//UIProgressView
#define ProgressView_(name,...) \
    zzn_strong_property(UIProgressView*,name,__VA_ARGS__)
//UIPageControl
#define PageControl_(name,...) \
    zzn_strong_property(UIPageControl*,name,__VA_ARGS__)
//UIStepper
#define Stepper_(name,...) \
    zzn_strong_property(UIStepper*,name,__VA_ARGS__)
//UITextView
#define TextView_(name,...) \
    zzn_strong_property(UITextView*,name,__VA_ARGS__)
//UIScrollView
#define ScrollView_(name,...) \
    zzn_strong_property(UIScrollView*,name,__VA_ARGS__)
//UIDatePicker
#define DatePicker_(name,...) \
    zzn_strong_property(UIDatePicker*,name,__VA_ARGS__)
//UIPickerView
#define PickerView_(name,...) \
    zzn_strong_property(UIPickerView*,name,__VA_ARGS__)
//UIWebView
#define WebView_(name,...) \
    zzn_strong_property(UIWebView*,name,__VA_ARGS__)
//自定义类
#define DIYObj_(class,name,...) \
    zzn_strong_property(class*,name,__VA_ARGS__)





/** assign */

//int
#define int_(name,...) \
    zzn_assign_property(int,name,__VA_ARGS__)
//float
#define float_(name,...) \
    zzn_assign_property(float,name,__VA_ARGS__)
//double
#define double_(name,...) \
    zzn_assign_property(double,name,__VA_ARGS__)
//CGFloat
#define CGFloat_(name,...) \
    zzn_assign_property(CGFloat,name,__VA_ARGS__)
//NSInteger
#define NSInteger_(name,...) \
    zzn_assign_property(NSInteger,name,__VA_ARGS__)
//NSUInteger
#define NSUInteger_(name,...) \
    zzn_assign_property(NSUInteger,name,__VA_ARGS__)
//BOOL
#define BOOL_(name,...) \
    zzn_assign_property(BOOL,name,__VA_ARGS__)
//CGRect
#define CGRect_(name,...) \
    zzn_assign_property(CGRect,name,__VA_ARGS__)
//CGSize
#define CGSize_(name,...) \
    zzn_assign_property(CGSize,name,__VA_ARGS__)
//CGPoint
#define CGPoint_(name,...) \
    zzn_assign_property(CGPoint,name,__VA_ARGS__)
//CGAffineTransform
#define CGAffineTransform_(name,...) \
    zzn_assign_property(CGAffineTransform,name,__VA_ARGS__)
//NSTimeInterval
#define NSTimeInterval_(name,...) \
    zzn_assign_property(NSTimeInterval,name,__VA_ARGS__)
//Class
#define Class_(name) \
    zzn_assign_property(Class,name)




/** weak */

//UIImageView
#define weakImageView_(name,...) \
    zzn_weak_property(UIImageView*,name,__VA_ARGS__)
//UIView
#define weakView_(name,...) \
    zzn_weak_property(UIView*,name,__VA_ARGS__)
//UILabel
#define weakLabel_(name,...) \
    zzn_weak_property(UILabel*,name,__VA_ARGS__)
//UIButton
#define weakButton_(name,...) \
    zzn_weak_property(UIButton*,name,__VA_ARGS__)
//UITableView
#define weakTableView_(name,...) \
    zzn_weak_property(UITableView*,name,__VA_ARGS__)
//UICollectionView
#define weakCollectionView_(name,...) \
    zzn_weak_property(UICollectionView*,name,__VA_ARGS__)
//UISegmentedControl
#define weakSegmentedControl_(name,...) \
    zzn_weak_property(UISegmentedControl*,name,__VA_ARGS__)
//UITextField
#define weakTextField_(name,...) \
    zzn_weak_property(UITextField*,name,__VA_ARGS__)
//UISlider
#define weakSlider_(name,...) \
    zzn_weak_property(UISlider*,name,__VA_ARGS__)
//UISwitch
#define weakSwitch_(name,...) \
    zzn_weak_property(UISwitch*,name,__VA_ARGS__)
//UIActivityIndicatorView
#define weakActivityIndicatorView_(name,...) \
    zzn_weak_property(UIActivityIndicatorView*,name,__VA_ARGS__)
//UIProgressView
#define weakProgressView_(name,...) \
    zzn_weak_property(UIProgressView*,name,__VA_ARGS__)
//UIPageControl
#define weakPageControl_(name,...) \
    zzn_weak_property(UIPageControl*,name,__VA_ARGS__)
//UIStepper
#define weakStepper_(name,...) \
    zzn_weak_property(UIStepper*,name,__VA_ARGS__)
//UITextView
#define weakTextView_(name,...) \
    zzn_weak_property(UITextView*,name,__VA_ARGS__)
//UIScrollView
#define weakScrollView_(name,...) \
    zzn_weak_property(UIScrollView*,name,__VA_ARGS__)
//UIDatePicker
#define weakDatePicker_(name,...) \
    zzn_weak_property(UIDatePicker*,name,__VA_ARGS__)
//UIPickerView
#define weakPickerView_(name,...) \
    zzn_weak_property(UIPickerView*,name,__VA_ARGS__)
//UIWebView
#define weakWebView_(name,...) \
    zzn_weak_property(UIWebView*,name,__VA_ARGS__)
//自定义类
#define weakDIYObj_(class,name,...) \
    zzn_weak_property(class*,name,__VA_ARGS__)

//delegate
#define Delegate_(class,name) \
    zzn_weak_property(id<class>,name)


/** base */

//copy && DIY
#define zzn_copy_property(class,var,...) \
    zzn_set_property(class,var,copy,__VA_ARGS__)
//strong && DIY
#define zzn_strong_property(class,var,...) \
    zzn_set_property(class,var,strong,__VA_ARGS__)
//weak && DIY
#define zzn_weak_property(class,var,...) \
    zzn_set_property(class,var,weak,__VA_ARGS__)
//assign && DIY
#define zzn_assign_property(class,var,...) \
    zzn_set_property(class,var,assign,__VA_ARGS__)
//DIY
#define zzn_diy_property(class,var,...) \
    zzn_set_property(class,var,__VA_ARGS__)
//block
#define zzn_set_block(class,name,...) \
    zzn_set_property(class,(^name)(__VA_ARGS__),copy)

//baseMacro
#define zzn_set_property(class,var,...) \
    @property (nonatomic, __VA_ARGS__) class var;



//设置 view 圆角和边框
#ifndef yViewBorderRadius
#define yViewBorderRadius(View,Radius,Width,Color)\
\[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]
#endif

#ifndef yKeyWindow
#define yKeyWindow          ([UIApplication sharedApplication].keyWindow)
#endif

#ifndef yAppDelegate
#define yAppDelegate        ([UIApplication sharedApplication].delegate)
#endif

/**懒加载*/
#ifndef LANJIAZAI
#define LANJIAZAI(class,name) -(class *)name { \
if (_##name == nil) { \
_##name = [[class alloc] init]; \
}\
return _##name;\
}
#endif

//字符串是否为空
#ifndef yStringIsEmpty
#define yStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
#endif

//数组是否为空
#ifndef yArrayIsEmpty
#define yArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
#endif

//字典是否为空
#ifndef yDictIsEmpty
#define yDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
#endif

//是否是空对象  ( " \ ":连接行标志，连接上下两行 )
#ifndef yObjectIsEmpty
#define yObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))
#endif

#define MAX_VALUE(X,Y) ((X) > (Y) ? (X) : (Y))// 求两个数中的最大值

//设置 view 圆角和边框
#define LRViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]


/***************************系统版本*****************************/

//获取手机系统的版本

#define HitoSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]

//是否为iOS7及以上系统

#define HitoiOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

//是否为iOS8及以上系统

#define HitoiOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)

//是否为iOS9及以上系统

#define HitoiOS9 ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0)

//是否为iOS10及以上系统

#define HitoiOS10 ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0)

//是否为iOS11及以上系统

#define HitoiOS11 ([[UIDevice currentDevice].systemVersion doubleValue] >= 11.0)





/**
 *     其他宏
 */
#define weakSelf(A) __weak A *weakSelf = self;

//block的调用
#define Call(block,...) \
    !block?:block(__VA_ARGS__);
//block的调用，并带有返回值
#define CallRerurn(block,failReturnValue,...) \
    block?(block(__VA_ARGS__)):(failReturnValue)

//防止block的强硬用循环相关
#define Weak(arg) \
    __weak typeof(arg) wArg = arg;
#define Strong(arg) \
    __strong typeof(wArg) arg = wArg;

#define WeakSelf \
    Weak(self)
#define StrongSelf \
    Strong(self)

