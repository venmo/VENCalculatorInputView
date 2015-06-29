#import "NSString+VENCalculatorInputView.h"

@implementation NSString (VENCalculatorInputView)

- (NSString *)stringByReplacingCharactersInSet:(NSCharacterSet *)characterSet
                                    withString:(NSString *)string
{
    return [[self componentsSeparatedByCharactersInSet:characterSet] componentsJoinedByString:string];
}

@end
