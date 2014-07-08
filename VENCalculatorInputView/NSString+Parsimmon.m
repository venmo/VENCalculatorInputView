#import "NSString+Parsimmon.h"

@implementation NSString (Parsimmon)

- (NSString *)stringByReplacingCharactersInSet:(NSCharacterSet *)characterSet
                                    withString:(NSString *)string
{
    return [[self componentsSeparatedByCharactersInSet:characterSet] componentsJoinedByString:string];
}

@end
