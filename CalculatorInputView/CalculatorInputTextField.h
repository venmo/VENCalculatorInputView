@import UIKit;

#import "CalculatorInputView.h"

@interface CalculatorInputTextField : UITextField <CalculatorInputViewDelegate>

/**
 The locale to use for the decimal separator.
 Defaults to locale for current device.
 */
@property (nonatomic) NSLocale *locale;

@end
