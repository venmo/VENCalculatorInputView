@import UIKit;

#import "CalculatorInputView.h"

@interface CalculatorInputTextField : UITextField <CalculatorInputViewDelegate>

/**
 The locale to use for the decimal separator.
 Defaults to locale for current device.
 */
@property (nonatomic) NSLocale *locale;

/**
 Prefix, such as '$' to always show in text field when non-empty
 */
@property (copy, nonatomic) NSString *prefix;

/**
 Whether or not to allow negative numbers.
 Defaults to YES.
 */
@property (assign, nonatomic) BOOL allowNegativeNumbers;

@end
