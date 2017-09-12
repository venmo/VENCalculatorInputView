@import UIKit;

@class CalculatorInputView;
@protocol CalculatorInputViewDelegate <NSObject>

@optional
- (void)calculatorInputView:(CalculatorInputView *)inputView didTapKey:(NSString *)key;
- (void)calculatorInputViewDidTapBackspace:(CalculatorInputView *)calculatorInputView;

@end

IB_DESIGNABLE
@interface CalculatorInputView : UIView <UIInputViewAudioFeedback>

@property (weak, nonatomic) id<CalculatorInputViewDelegate> delegate;

/**-----------------------------------------------------------------------------
 * @name Localization
 * -----------------------------------------------------------------------------
 */

/**
 The locale to use for the decimal separator.
 Defaults to locale for current device.
 */
@property (nonatomic) NSLocale *locale;


/**-----------------------------------------------------------------------------
 * @name Customizing colors
 * -----------------------------------------------------------------------------
 */

@property (nonatomic) UIColor *buttonTitleColor;
@property (nonatomic) UIFont *buttonTitleFont;
@property (nonatomic) UIColor *buttonHighlightedColor;

@property (nonatomic) UIColor *numberButtonBackgroundColor;
@property (nonatomic) UIColor *numberButtonBorderColor;

@property (nonatomic) UIColor *operationButtonBackgroundColor;
@property (nonatomic) UIColor *operationButtonBorderColor;

@end
