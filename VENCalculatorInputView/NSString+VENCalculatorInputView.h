#import <Foundation/Foundation.h>

@interface NSString (VENCalculatorInputView)

- (NSString *)stringByReplacingCharactersInSet:(NSCharacterSet *)characterSet
                                    withString:(NSString *)string;

@end
