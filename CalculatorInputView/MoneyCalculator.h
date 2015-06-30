@import Foundation;

@interface MoneyCalculator : NSObject

@property (nonatomic, nonnull) NSLocale *locale;

/**
 * Evaluates a mathematical expression containing +, −, ×, and ÷.
 * @param expression The expression to evaluate
 * @return The evaluated expression. Returns nil if the expression is invalid.
 */
- (nullable NSString *)evaluateExpression:(nonnull NSString *)expression;

@end
