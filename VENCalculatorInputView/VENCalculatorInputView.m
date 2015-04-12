#import "VENCalculatorInputView.h"

@interface VENCalculatorInputView ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberButtonCollection;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *operationButtonCollection;
@property (strong, nonatomic) IBOutlet UIButton *decimalButton;

@end

@implementation VENCalculatorInputView

- (id)initWithFrame:(CGRect)frame {
    self = [[[NSBundle bundleForClass:[self class]]  loadNibNamed:@"VENCalculatorInputView" owner:self options:nil] firstObject];
    if (self) {
        // Set default locale
        self.locale = [NSLocale currentLocale];

        // Set customizable properties
        [self setNumberButtonBackgroundColor:[UIColor colorWithWhite:0.98828 alpha:1]];
        [self setNumberButtonBorderColor:[UIColor colorWithRed:193/255.0f green:195/255.0f blue:199/255.0f alpha:1]];
        [self setOperationButtonBackgroundColor:[UIColor colorWithRed:193/255.0f green:196/255.0f blue:200/255.0f alpha:1]];
        [self setOperationButtonBorderColor:[UIColor colorWithRed:172/255.0f green:174/255.0f blue:177/255.0f alpha:1]];
        [self setButtonHighlightedColor:[UIColor grayColor]];
        [self setButtonTitleColor:[UIColor darkTextColor]];

        // Set default properties
        for (UIButton *numberButton in self.numberButtonCollection) {
            [self setupButton:numberButton];
        }
        for (UIButton *operationButton in self.operationButtonCollection) {
            [self setupButton:operationButton];
        }
    }
    return self;
}

- (void)setLocale:(NSLocale *)locale {
    _locale = locale;
    NSString *decimalSymbol = [locale objectForKey:NSLocaleDecimalSeparator];
    [self.decimalButton setTitle:decimalSymbol forState:UIControlStateNormal];
}

- (void)setupButton:(UIButton *)button {
    button.layer.borderWidth = 0.25f;
}

- (IBAction)userDidTapBackspace:(UIButton *)sender {
    [[UIDevice currentDevice] playInputClick];
    if ([self.delegate respondsToSelector:@selector(calculatorInputViewDidTapBackspace:)]) {
        [self.delegate calculatorInputViewDidTapBackspace:self];
    }
}

- (IBAction)userDidTapKey:(UIButton *)sender {
    [[UIDevice currentDevice] playInputClick];
    if ([self.delegate respondsToSelector:@selector(calculatorInputView:didTapKey:)]) {
        [self.delegate calculatorInputView:self didTapKey:sender.titleLabel.text];
    }
}


#pragma mark - UIInputViewAudioFeedback

- (BOOL)enableInputClicksWhenVisible {
    return YES;
}


#pragma mark - Helpers

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();

    [color set];
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


#pragma mark - Properties

- (void)setButtonTitleColor:(UIColor *)buttonTitleColor {
    _buttonTitleColor = buttonTitleColor;
    for (UIButton *numberButton in self.numberButtonCollection) {
        [numberButton setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    }
    for (UIButton *operationButton in self.operationButtonCollection) {
        [operationButton setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    }
}

- (void)setButtonTitleFont:(UIFont *)buttonTitleFont {
    _buttonTitleFont = buttonTitleFont;
    for (UIButton *numberButton in self.numberButtonCollection) {
        numberButton.titleLabel.font = buttonTitleFont;
    }
    for (UIButton *operationButton in self.operationButtonCollection) {
        operationButton.titleLabel.font = buttonTitleFont;
    }
}

- (void)setButtonHighlightedColor:(UIColor *)buttonHighlightedColor {
    _buttonHighlightedColor = buttonHighlightedColor;
    for (UIButton *numberButton in self.numberButtonCollection) {
        [numberButton setBackgroundImage:[self imageWithColor:buttonHighlightedColor size:CGSizeMake(50, 50)]
                                forState:UIControlStateHighlighted];
    }
    for (UIButton *operationButton in self.operationButtonCollection) {
        [operationButton setBackgroundImage:[self imageWithColor:buttonHighlightedColor size:CGSizeMake(50, 50)]
                                   forState:UIControlStateHighlighted];
    }
}

- (void)setNumberButtonBackgroundColor:(UIColor *)numberButtonBackgroundColor {
    _numberButtonBackgroundColor = numberButtonBackgroundColor;
    for (UIButton *numberButton in self.numberButtonCollection) {
        numberButton.backgroundColor = numberButtonBackgroundColor;
    }
}

- (void)setNumberButtonBorderColor:(UIColor *)numberButtonBorderColor {
    _numberButtonBorderColor = numberButtonBorderColor;
    for (UIButton *numberButton in self.numberButtonCollection) {
        numberButton.layer.borderColor = numberButtonBorderColor.CGColor;
    }
}

- (void)setOperationButtonBackgroundColor:(UIColor *)operationButtonBackgroundColor {
    _operationButtonBackgroundColor = operationButtonBackgroundColor;
    for (UIButton *operationButton in self.operationButtonCollection) {
        operationButton.backgroundColor = operationButtonBackgroundColor;
    }
}

- (void)setOperationButtonBorderColor:(UIColor *)operationButtonBorderColor {
    _operationButtonBorderColor = operationButtonBorderColor;
    for (UIButton *operationButton in self.operationButtonCollection) {
        operationButton.layer.borderColor = operationButtonBorderColor.CGColor;
    }
}

@end
