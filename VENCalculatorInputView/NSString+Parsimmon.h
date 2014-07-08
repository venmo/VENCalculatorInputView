#import <Foundation/Foundation.h>

@interface NSString (Parsimmon)

- (NSString *)stringByReplacingCharactersInSet:(NSCharacterSet *)characterSet
                                    withString:(NSString *)string;

@end
