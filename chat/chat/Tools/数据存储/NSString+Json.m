//
//  NSString+Json.m


#import "NSString+Json.h"

@implementation NSString (Json)

- (id)objectFromJSONString{
    return [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
}

@end
