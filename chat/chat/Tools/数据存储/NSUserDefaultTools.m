//
//  NSUserDefaultTools.m


#import "NSUserDefaultTools.h"
#import "NSObject+Json.h"
#import "NSString+Json.h"
@implementation NSUserDefaultTools

+ (void)setStringValueWithKey:(NSString *)value key:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:value forKey:key];
    [defaults synchronize];
}
+ (NSString *)getStringValueWithKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}

+ (void)setBooleanValueWithKey:(BOOL)value key:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:value forKey:key];
    [defaults synchronize];
}
+ (BOOL)getBooleanValueWithKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:key];
}

+ (void)setUserInfo:(NSDictionary *)userInfo {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:[userInfo JSONString] forKey:@"userInfo"];
    [defaults synchronize];
}

+ (NSDictionary *)getUserInfo {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userInfoStr = [defaults stringForKey:@"userInfo"];
    NSDictionary *userInfo = [userInfoStr objectFromJSONString];
    if (userInfo != nil && [userInfo isKindOfClass:[NSDictionary class]]) {
        return userInfo;
    }
    return nil;
}

+ (void)setDataWithKey:(NSData *)data key:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:data forKey:key];
    [defaults synchronize];
}

+ (NSData *)getDataWithKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}



@end
