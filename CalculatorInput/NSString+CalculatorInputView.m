#import "NSString+CalculatorInputView.h"

@implementation NSString (CalculatorInputView)

- (NSString *)ven_stringByReplacingCharactersInSet:(NSCharacterSet *)characterSet
                                    withString:(NSString *)string
{
    return [[self componentsSeparatedByCharactersInSet:characterSet] componentsJoinedByString:string];
}

@end
