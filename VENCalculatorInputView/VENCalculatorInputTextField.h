#import <UIKit/UIKit.h>
#import "VENCalculatorInputView.h"

@interface VENCalculatorInputTextField : UITextField <VENCalculatorInputViewDelegate>

/**
 The locale to use for the decimal separator.
 Defaults to locale for current device.
 */
@property (strong, nonatomic) NSLocale *locale;

@end
