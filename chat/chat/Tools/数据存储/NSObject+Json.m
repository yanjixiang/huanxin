//
//  NSObject+Json.m


#import "NSObject+Json.h"

@implementation NSObject (Json)

- (NSString *)JSONString{
    NSString *result = nil;
    if (self != nil) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
        if (data == nil) {
            return nil;
        }
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return result;
}

@end
