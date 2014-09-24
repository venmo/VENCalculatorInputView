#import <UIKit/UIKit.h>
#import "VENCalculatorInputView.h"

@interface VENCalculatorInputTextField : UITextField <VENCalculatorInputViewDelegate>

/**
 The locale to use for the decimal separator.
 Defaults to locale for current device.
 */
@property (strong, nonatomic) NSLocale *locale;


/**
Style of the keyboard.
Can be set as runtime attribute in Interface Builder.
*/
@property VENCalculatorInputViewStyle style;


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
