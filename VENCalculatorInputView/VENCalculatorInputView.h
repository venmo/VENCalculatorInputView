#import <UIKit/UIKit.h>

@class VENCalculatorInputView;
@protocol VENCalculatorInputViewDelegate <NSObject>

@optional
- (void)calculatorInputView:(VENCalculatorInputView *)inputView didTapKey:(NSString *)key;
- (void)calculatorInputViewDidTapBackspace:(VENCalculatorInputView *)calculatorInputView;

@end

@interface VENCalculatorInputView : UIView <UIInputViewAudioFeedback>

@property (weak, nonatomic) id<VENCalculatorInputViewDelegate> delegate;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberButtonCollection;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *operationButtonCollection;


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
