//
//  NSUserDefaultTools.h


#import <Foundation/Foundation.h>

@interface NSUserDefaultTools : NSObject


//保存bool类型
+ (void)setBooleanValueWithKey:(BOOL)value key:(NSString *)key;
//取值bool类型
+ (BOOL)getBooleanValueWithKey:(NSString *)key;
//保存字符串类型
+ (void)setStringValueWithKey:(NSString *)value key:(NSString *)key;
//取字符串类型值
+ (NSString *)getStringValueWithKey:(NSString *)key;

//保存一个字典
+ (void)setUserInfo:(NSDictionary *)userInfo;


/**
 返回值为空时，可以看做未登录
 */

+ (NSDictionary *)getUserInfo;

//保存一个NSArray
/*
 *  NSArray *arr1 = [[NSArray alloc]initWithObjects:@"0",@"5",nil];
 NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arr1];
 
 [NSUserDefaultTools setDataWithKey:data key:@"saveArray"];
 
 NSArray *arr2 = [NSKeyedUnarchiver unarchiveObjectWithData:[NSUserDefaultTools getDataWithKey:@"saveArray"]];
 NSLog(@"取出数组=======%@",arr2);
 */
+ (void)setDataWithKey:(NSData *)data key:(NSString *)key;
+ (NSData *)getDataWithKey:(NSString *)key;

/*
 *保存自定义的对象
LoginInfo  *userinfo=[[LoginInfo alloc]init];

userinfo.resMsg=@"呵呵呵";
userinfo.sign=@"哈哈";

NSData *Logindata = [NSKeyedArchiver archivedDataWithRootObject:userinfo];

[NSUserDefaultTools setDataWithKey:Logindata key:@"saveUserinfo"];


LoginInfo *info = [NSKeyedUnarchiver unarchiveObjectWithData:[NSUserDefaultTools getDataWithKey:@"saveUserinfo"]];

NSLog(@"取出自定义对象=======%@",info);

 */

@end
