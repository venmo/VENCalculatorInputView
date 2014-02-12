#import "VENCalculatorInputTextField.h"
#import "VENMoneyCalculator.h"

@implementation VENCalculatorInputTextField

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpInit];
    }
    return self;
}

- (void)awakeFromNib {
    [self setUpInit];
}

- (void)setUpInit {
    self.inputView = [[VENCalculatorInputView alloc] init];
    ((VENCalculatorInputView *)self.inputView).delegate = self;
    [self addTarget:self action:@selector(venCalculatorTextFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self addTarget:self action:@selector(venCalculatorTextFieldDidEndEditing) forControlEvents:UIControlEventEditingDidEnd];
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
        NSString *evaluatedString = [VENMoneyCalculator evaluateExpression:subString];
        if (evaluatedString) {
            self.text = [NSString stringWithFormat:@"%@%@", evaluatedString, lastCharacterString];
        } else {
            self.text = subString;
        }
    } else if ([lastCharacterString isEqualToString:@"."]) {
        NSString *secondToLastCharacterString = [self.text substringWithRange:NSMakeRange([self.text length] - 2, 1)];
        if ([secondToLastCharacterString isEqualToString:@"."]) {
            self.text = subString;
        }
    }
}

- (void)venCalculatorTextFieldDidEndEditing {
    NSString *textToEvaluate = [self trimExpressionString:self.text];
    NSString *evaluatedString = [VENMoneyCalculator evaluateExpression:textToEvaluate];
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
            [lastCharacterString isEqualToString:@"."]) {
            return [self.text substringToIndex:self.text.length - 1];
        }
    }
    return expressionString;
}

@end
