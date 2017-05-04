#import "MoneyCalculator.h"
#import "NSString+CalculatorInputView.h"

@import CoreGraphics;

@interface MoneyCalculator ()
@property (strong, nonatomic) NSNumberFormatter *numberFormatter;
@end

@implementation MoneyCalculator

- (instancetype)init {
    self = [super init];
    if (self) {
        self.locale = [NSLocale currentLocale];
    }
    return self;
}

- (NSString *)evaluateExpression:(NSString *)expressionString {
    return [self evaluateExpression:expressionString allowNegativeResult:YES];
}

- (NSString *)evaluateExpression:(NSString *)expressionString allowNegativeResult:(BOOL)allowNegativeResult {
    if (!expressionString) {
        return nil;
    }
    NSString *sanitizedString = [self sanitizedString:expressionString];
    NSString *floatString = [NSString stringWithFormat:@"1.0*%@", sanitizedString];
    NSExpression *expression;
    id result;
    @try {
        expression = [NSExpression expressionWithFormat:floatString];
        result = [expression expressionValueWithObject:nil context:nil];
    }
    @catch (NSException *exception) {
        if ([[exception name] isEqualToString:NSInvalidArgumentException]) {
            return nil;
        } else {
            [exception raise];
        }
    }
    if (![result isKindOfClass:[NSNumber class]]) {
        return nil;
    }
    
    NSNumber *number = (NSNumber *)result;
    NSDecimalNumber *decimalNumber = [[NSDecimalNumber alloc] initWithDecimal:number.decimalValue];
    
    if ([self decimalNumberIsValid:decimalNumber allowNegativeValues:allowNegativeResult]) {
        return [self formattedDecimalNumber:decimalNumber];
    } else {
        return [self formattedDecimalNumber:[NSDecimalNumber zero]];
    }
}

- (void)setLocale:(NSLocale *)locale {
    _locale = locale;
    self.numberFormatter.locale = locale;
}


#pragma mark - Private

- (NSNumberFormatter *)numberFormatter {
    if (!_numberFormatter) {
        _numberFormatter = [NSNumberFormatter new];
        [_numberFormatter setLocale:self.locale];
        [_numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [_numberFormatter setCurrencySymbol:@""];
    }
    return _numberFormatter;
}

- (NSString *)sanitizedString:(NSString *)string {
    NSString *groupingSeperator = [self.locale objectForKey:NSLocaleGroupingSeparator];
    NSString *withoutGroupingSeperator = [string stringByReplacingOccurrencesOfString:groupingSeperator withString:@""];
    return [[self replaceOperandsInString:withoutGroupingSeperator] ven_stringByReplacingCharactersInSet:[self illegalCharacters] withString:@""];
}

- (NSString *)replaceOperandsInString:(NSString *)string {
    NSString *subtractReplaced = [string stringByReplacingOccurrencesOfString:@"−" withString:@"-"];
    NSString *divideReplaced = [subtractReplaced stringByReplacingOccurrencesOfString:@"÷" withString:@"/"];
    NSString *multiplyReplaced = [divideReplaced stringByReplacingOccurrencesOfString:@"×" withString:@"*"];

    return [multiplyReplaced stringByReplacingOccurrencesOfString:[self decimalSeparator] withString:@"."];
}

- (NSString *)formattedDecimalNumber:(NSDecimalNumber *)decimalNumber {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [[[self numberFormatter] stringFromNumber:decimalNumber] stringByTrimmingCharactersInSet:set];
}

- (BOOL)decimalNumberIsValid:(NSDecimalNumber *)decimalNumber allowNegativeValues:(BOOL)allowNegativeValues {
    if ([decimalNumber isEqual:[NSDecimalNumber notANumber]]) {
        return NO;
    }

    if ([decimalNumber compare:[NSDecimalNumber zero]] == NSOrderedAscending && !allowNegativeValues) {
        return NO;
    }

    if ([decimalNumber compare:[NSDecimalNumber minimumDecimalNumber]] == NSOrderedAscending
        || [decimalNumber compare:[NSDecimalNumber maximumDecimalNumber]] == NSOrderedDescending) {
        return NO;
    }

    return YES;
}

- (NSCharacterSet *)illegalCharacters {
    return [[NSCharacterSet characterSetWithCharactersInString:@"0123456789-/*.+"] invertedSet];
}

- (NSString *)decimalSeparator {
    return [self.locale objectForKey:NSLocaleDecimalSeparator];
}

@end
