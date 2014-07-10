#import "UITextRange+VENCalculatorInputView.h"

@implementation UITextRange (VENCalculatorInputView)

- (NSRange)nsRangeFromTextRangeInTextField:(UITextField *)textField
{
    UITextPosition* beginning = textField.beginningOfDocument;

    UITextRange* selectedRange = textField.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;

    const NSInteger location = [textField offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [textField offsetFromPosition:selectionStart toPosition:selectionEnd];

    return NSMakeRange(location, length);
}

@end
