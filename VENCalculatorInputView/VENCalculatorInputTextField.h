#import <UIKit/UIKit.h>
#import "VENCalculatorInputView.h"

@interface VENCalculatorInputTextField : UITextField <VENCalculatorInputViewDelegate>

/**
 The locale to use for the decimal separator.
 Defaults to locale for current device.
 */
@property (strong, nonatomic) NSLocale *locale;


/**
 Default initializer.
 Inits with VENCalculatorInputViewStyleDefault.
 */
- (instancetype)initWithFrame:(CGRect)frame;


/**
 Designated initializer.
 */
- (instancetype)initWithFrame:(CGRect)frame keyboardStyle:(VENCalculatorInputViewStyle)style;

@end
