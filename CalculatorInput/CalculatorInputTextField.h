@import UIKit;

#import "CalculatorInputView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CalculatorInputTextField : UITextField <CalculatorInputViewDelegate>

/**
 The locale to use for the decimal separator.
 Defaults to locale for current device.
 */
@property (nonatomic) NSLocale *locale;

/**
 The currency code to use.
 Defaults to the Locale currency
 */
@property (nonatomic, nullable) NSString *currencyCode;

/**
 Prefix, such as '$' to always show in text field when non-empty
 */
@property (copy, nonatomic) NSString *prefix;

/**
 Whether or not to allow negative numbers.
 Defaults to YES.
 */
@property (assign, nonatomic) BOOL allowNegativeNumbers;


/**
 Get the current evaluated string, even if you're still editing.
 */
@property (nonatomic, readonly) NSString *currentEvaluatedString;

/**
 Get the current evaluated string, with proposed changes.
 */
-(NSString *)currentEvaluatedStringWithChangedCharactersInRange:(NSRange)range replacementString:(NSString *)replacementString;

@end

NS_ASSUME_NONNULL_END
