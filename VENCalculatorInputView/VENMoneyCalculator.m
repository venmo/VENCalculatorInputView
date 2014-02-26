#import "VENMoneyCalculator.h"

@implementation VENMoneyCalculator

+ (NSString *)evaluateExpression:(NSString *)expressionString {
    if (!expressionString) {
        return nil;
    }
    NSString *floatString = [NSString stringWithFormat:@"1.0*%@", expressionString];
    NSString *sanitizedString = [VENMoneyCalculator replaceOperandsInString:floatString];
    NSExpression *expression;
    @try {
        expression = [NSExpression expressionWithFormat:sanitizedString];
    }
    @catch (NSException *exception) {
        if ([[exception name] isEqualToString:NSInvalidArgumentException]) {
            return nil;
        } else {
            [exception raise];
        }
    }
    id result = [expression expressionValueWithObject:nil context:nil];
    if ([result isKindOfClass:[NSNumber class]]) {
        NSInteger integerExpression = [(NSNumber *)result integerValue];
        CGFloat floatExpression = [(NSNumber *)result floatValue];
        if (integerExpression == floatExpression) {
            return [(NSNumber *)result stringValue];
        } else if (floatExpression >= CGFLOAT_MAX || floatExpression <= CGFLOAT_MIN) {
            return @"0";
        } else {
            return [NSString stringWithFormat:@"%.2f", floatExpression];
        }
    } else {
        return nil;
    }
}


#pragma mark - Private

+ (NSString *)replaceOperandsInString:(NSString *)string {
    NSString *subtractReplaced = [string stringByReplacingOccurrencesOfString:@"−" withString:@"-"];
    NSString *divideReplaced = [subtractReplaced stringByReplacingOccurrencesOfString:@"÷" withString:@"/"];
    return [divideReplaced stringByReplacingOccurrencesOfString:@"×" withString:@"*"];
}

@end
