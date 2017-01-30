@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface NSString (CalculatorInputView)

- (NSString *)ven_stringByReplacingCharactersInSet:(NSCharacterSet *)characterSet
                                    withString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
