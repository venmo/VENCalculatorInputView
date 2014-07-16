#import "VENCalculatorInputTextField.h"
#import "VENMoneyCalculator.h"

@interface VENCalculatorInputTextField ()
@property (strong, nonatomic) VENMoneyCalculator *moneyCalculator;
@end

@implementation VENCalculatorInputTextField

- (instancetype)initWithFrame:(CGRect)frame keyboardStyle:(VENCalculatorInputViewStyle)style {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpInitWithStyle:style];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpInitWithStyle:VENCalculatorInputViewStyleDefault];
    }
    return self;
}

- (void)awakeFromNib {
    [self setUpInitWithStyle:VENCalculatorInputViewStyleDefault];
}

- (void)setUpInitWithStyle:(VENCalculatorInputViewStyle)style {
    self.locale = [NSLocale currentLocale];

    VENCalculatorInputView *inputView = [[VENCalculatorInputView alloc] initWithStyle:style];
    inputView.delegate = self;
    inputView.locale = self.locale;
    self.inputView = inputView;

    VENMoneyCalculator *moneyCalculator = [VENMoneyCalculator new];
    moneyCalculator.locale = self.locale;
    self.moneyCalculator = moneyCalculator;

    [self addTarget:self action:@selector(venCalculatorTextFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self addTarget:self action:@selector(venCalculatorTextFieldDidEndEditing) forControlEvents:UIControlEventEditingDidEnd];
}


#pragma mark - Properties

- (void)setLocale:(NSLocale *)locale {
    _locale = locale;
    VENCalculatorInputView *inputView = (VENCalculatorInputView*)self.inputView;
    inputView.locale = locale;
    self.moneyCalculator.locale = locale;
}


#pragma mark - UITextField

- (void)venCalculatorTextFieldDidChange {
    if (![self.text length]) return;

    NSString *lastCharacterString = [self.text substringFromIndex:[self.text length] - 1];
    NSString *subString = [self.text substringToIndex:self.text.length - 1];
    if ([lastCharacterString isEqualToString:@"+"] ||
        [lastCharacterString isEqualToString:@"−"] ||
        [lastCharacterString isEqualToString:@"×"] ||
        [lastCharacterString isEqualToString:@"÷"]) {
        NSString *evaluatedString = [self.moneyCalculator evaluateExpression:subString];
        if (evaluatedString) {
            self.text = [NSString stringWithFormat:@"%@%@", evaluatedString, lastCharacterString];
        } else {
            self.text = subString;
        }
    } else if ([lastCharacterString isEqualToString:[self decimalSeparator]] && [self.text length] > 1) {
        NSString *secondToLastCharacterString = [self.text substringWithRange:NSMakeRange([self.text length] - 2, 1)];
        if ([secondToLastCharacterString isEqualToString:[self decimalSeparator]]) {
            self.text = subString;
        }
    }
}

- (void)venCalculatorTextFieldDidEndEditing {
    NSString *textToEvaluate = [self trimExpressionString:self.text];
    NSString *evaluatedString = [self.moneyCalculator evaluateExpression:textToEvaluate];
    if (evaluatedString) {
        self.text = evaluatedString;
    }
}


#pragma mark - VENCalculatorInputViewDelegate

- (void)calculatorInputView:(VENCalculatorInputView *)inputView didTapKey:(NSString *)key {
    [self insertText:key];
}

- (void)calculatorInputViewDidTapBackspace:(VENCalculatorInputView *)calculatorInputView {
    [self deleteBackward];
}

- (void)calculatorInputViewDidTapEquals:(VENCalculatorInputView *)calculatorInputView {
    [self venCalculatorTextFieldDidEndEditing];
    [self endEditing:YES];
}

- (void)calculatorInputViewDidTapClear:(VENCalculatorInputView *)calculatorInputView {
    self.text = @"";
}


#pragma mark - Helpers

/**
 Removes any trailing operations and decimals.
 @param expressionString The expression string to trim
 @return The trimmed expression string
 */
- (NSString *)trimExpressionString:(NSString *)expressionString {
    if ([self.text length] > 0) {
        NSString *lastCharacterString = [self.text substringFromIndex:[self.text length] - 1];
        if ([lastCharacterString isEqualToString:@"+"] ||
            [lastCharacterString isEqualToString:@"−"] ||
            [lastCharacterString isEqualToString:@"×"] ||
            [lastCharacterString isEqualToString:@"÷"] ||
            [lastCharacterString isEqualToString:[self decimalSeparator]]) {
            return [self.text substringToIndex:self.text.length - 1];
        }
    }
    return expressionString;
}

- (NSString *)decimalSeparator {
    return [self.locale objectForKey:NSLocaleDecimalSeparator];
}

@end
