#import "UITextField+CalculatorInputView.h"

@implementation UITextField (CalculatorInputView)

- (NSRange)ven_selectedNSRange
{
    UITextPosition *beginning = self.beginningOfDocument;

    UITextRange *selectedRange = self.selectedTextRange;
    UITextPosition *selectionStart = selectedRange.start;
    UITextPosition *selectionEnd = selectedRange.end;

    NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];

    return NSMakeRange(location, length);
}

@end
