@import Foundation;

@interface MoneyCalculator : NSObject

@property (nonatomic, nonnull) NSLocale *locale;

/**
 * Evaluates a mathematical expression containing +, −, ×, and ÷.
 * @param expression The expression to evaluate
 * @return The evaluated expression. Returns nil if the expression is invalid.
 */
- (nullable NSString *)evaluateExpression:(nonnull NSString *)expression;

/**
 * Evaluates a mathematical expression containing +, −, ×, and ÷.
 * @param expression The expression to evaluate
 * @param allowNegativeResult Whether or not to allow negative results. Returns "0" if result is negative.
 * @return The evaluated expression. Returns nil if the expression is invalid.
 */
- (nullable NSString *)evaluateExpression:(nonnull NSString *)expression allowNegativeResult:(BOOL)allowNegativeResult;

@end
