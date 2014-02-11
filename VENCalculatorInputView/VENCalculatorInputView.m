#import "VENCalculatorInputView.h"

@implementation VENCalculatorInputView

- (id)initWithFrame:(CGRect)frame {
    self = [[[NSBundle mainBundle] loadNibNamed:@"VENCalculatorInputView" owner:self options:nil] firstObject];
    if (self) {
        for (UIButton *numberButton in self.numberButtonCollection) {
            [self setupButton:numberButton];
            [numberButton setBackgroundColor:[UIColor colorWithWhite:0.98828 alpha:1]];
            numberButton.layer.borderColor = [UIColor colorWithRed:193/255.0f green:195/255.0f blue:199/255.0f alpha:1].CGColor;
        }
        for (UIButton *operationButton in self.operationButtonCollection) {
            [self setupButton:operationButton];
            [operationButton setBackgroundColor:[UIColor colorWithRed:193/255.0f green:196/255.0f blue:200/255.0f alpha:1]];
            operationButton.layer.borderColor = [UIColor colorWithRed:172/255.0f green:174/255.0f blue:177/255.0f alpha:1].CGColor;
        }
    }
    return self;
}

- (void)setupButton:(UIButton *)button {
    button.adjustsImageWhenHighlighted = YES;
    [button setBackgroundImage:nil forState:UIControlStateNormal];
    [button setBackgroundImage:nil forState:UIControlStateHighlighted];
    [button setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[self imageWithColor:[UIColor grayColor] size:CGSizeMake(50, 50)] forState:UIControlStateHighlighted];
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
    UIGraphicsBeginImageContextWithOptions(size, NO, .0);
    CGContextRef context = UIGraphicsGetCurrentContext();

    [color set];
    CGContextFillRect(context, CGRectMake(.0, .0, size.width, size.height));

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
