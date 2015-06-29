@import UIKit;

//! Project version number for CalculatorInputView.
FOUNDATION_EXPORT double CalculatorInputViewVersionNumber;

//! Project version string for CalculatorInputView.
FOUNDATION_EXPORT const unsigned char CalculatorInputViewVersionString[];

@class CalculatorInputView;
@protocol CalculatorInputViewDelegate <NSObject>

@optional
- (void)calculatorInputView:(CalculatorInputView *)inputView didTapKey:(NSString *)key;
- (void)calculatorInputViewDidTapBackspace:(CalculatorInputView *)calculatorInputView;

@end

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
@property (strong, nonatomic) NSLocale *locale;


/**-----------------------------------------------------------------------------
 * @name Customizing colors
 * -----------------------------------------------------------------------------
 */

@property (strong, nonatomic) UIColor *buttonTitleColor;
@property (strong, nonatomic) UIFont  *buttonTitleFont;
@property (strong, nonatomic) UIColor *buttonHighlightedColor;

@property (strong, nonatomic) UIColor *numberButtonBackgroundColor;
@property (strong, nonatomic) UIColor *numberButtonBorderColor;

@property (strong, nonatomic) UIColor *operationButtonBackgroundColor;
@property (strong, nonatomic) UIColor *operationButtonBorderColor;

@end


#import <CalculatorInputView/CalculatorInputTextField.h>
