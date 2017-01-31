#import "CalculatorInputTextField.h"
#import "MoneyCalculator.h"
#import "UITextField+CalculatorInputView.h"

@interface CalculatorInputTextField ()
@property (strong, nonatomic) MoneyCalculator *moneyCalculator;
@end

@implementation CalculatorInputTextField

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
    self.locale = [NSLocale currentLocale];

    CalculatorInputView *inputView = [CalculatorInputView new];
    inputView.delegate = self;
    inputView.locale = self.locale;
    self.inputView = inputView;
    self.prefix = @"";

    MoneyCalculator *moneyCalculator = [MoneyCalculator new];
    moneyCalculator.locale = self.locale;
    self.moneyCalculator = moneyCalculator;

    [self addTarget:self action:@selector(venCalculatorTextFieldDidEndEditing) forControlEvents:UIControlEventEditingDidEnd];
}


#pragma mark - Properties

- (void)setLocale:(NSLocale *)locale {
    _locale = locale;
    CalculatorInputView *inputView = (CalculatorInputView *)self.inputView;
    inputView.locale = locale;
    self.moneyCalculator.locale = locale;
}

-(NSString *)evaluateString:(NSString *)text{
    NSString *textToEvaluate = [self trimExpressionString:text];
    NSString *evaluatedString = [self.moneyCalculator evaluateExpression:textToEvaluate allowNegativeResult:NO];
    return evaluatedString;
}

- (NSString *)currentEvaluatedString {
    if(self.text.length == 0){
        return @"";
    }else{
        return [self evaluateString:self.text];
    }
}
-(NSString *)currentEvaluatedStringWithChangedCharactersInRange:(NSRange)range replacementString:(NSString *)replacementString{
    NSString *updatedText = [self.text stringByReplacingCharactersInRange:range withString:replacementString];
    if(updatedText.length == 0){
        return updatedText;
    }else{
        return [self evaluateString:updatedText];
    }
}

#pragma mark - UITextField

- (void)venCalculatorTextFieldDidEndEditing {
    NSString *evaluatedString = [self currentEvaluatedString];
    if (evaluatedString) {
        self.text = evaluatedString;
    }
    [self addPrefix];
}


#pragma mark - CalculatorInputViewDelegate

- (void)calculatorInputView:(CalculatorInputView *)inputView didTapKey:(NSString *)key {
    if ([self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        NSRange range = [self ven_selectedNSRange];
        if (![self.delegate textField:self shouldChangeCharactersInRange:range replacementString:key]) {
            return;
        }
    }

    [self insertText:key];
    NSString *subString = [self.text substringToIndex:self.text.length - 1];
    if ([key isEqualToString:@"+"] ||
        [key isEqualToString:@"−"] ||
        [key isEqualToString:@"×"] ||
        [key isEqualToString:@"÷"]) {
        NSString *evaluatedString = [self.moneyCalculator evaluateExpression:[self trimExpressionString:subString]];
        if (evaluatedString) {
            self.text = [NSString stringWithFormat:@"%@%@", evaluatedString, key];
        } else {
            self.text = subString;
        }
    } else if ([key isEqualToString:[self decimalSeparator]] && self.text.length > 1) {
        NSString *secondToLastCharacterString = [self.text substringWithRange:NSMakeRange([self.text length] - 2, 1)];
        if ([secondToLastCharacterString isEqualToString:[self decimalSeparator]]) {
            self.text = subString;
        }
    }
    [self addPrefix];
}

- (void)calculatorInputViewDidTapBackspace:(CalculatorInputView *)calculatorInputView {
    [self deleteBackward];

    if ([self.text isEqualToString:self.prefix]) {
        [self deleteBackward];
    }
}


#pragma mark - Helpers

/**
 Removes any trailing operations and decimals.
 @param expressionString The expression string to trim
 @return The trimmed expression string
 */
- (NSString *)trimExpressionString:(NSString *)expressionString {
    NSString *txt = expressionString;
    while ([txt length] > 0) {
        NSString *lastCharacterString = [txt substringFromIndex:[txt length] - 1];
        if ([lastCharacterString isEqualToString:@"+"] ||
            [lastCharacterString isEqualToString:@"−"] ||
            [lastCharacterString isEqualToString:@"×"] ||
            [lastCharacterString isEqualToString:@"÷"] ||
            [lastCharacterString isEqualToString:self.decimalSeparator]) {
            txt = [txt substringToIndex:txt.length - 1];
        }
        else {
            break;
        }
    }
    return txt;
}

- (NSString *)decimalSeparator {
    return [self.locale objectForKey:NSLocaleDecimalSeparator];
}

- (void)addPrefix {
    if (self.text.length > 0 && ![self.text hasPrefix:self.prefix]) {
        self.text = [self.prefix stringByAppendingString:self.text];
    }
}

@end
