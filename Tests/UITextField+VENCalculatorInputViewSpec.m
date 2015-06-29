#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <Specta/Specta.h>
#import <OCMock/OCMock.h>

#import "UITextField+VENCalculatorInputView.h"

SpecBegin(UITextRange_VENCalculatorInputView)

describe(@"selectedNSRange", ^{

    it(@"should get UITextField's selectedText in an NSRange", ^{
        id mockBeginningTextPosition = OCMClassMock([UITextPosition class]);
        id mockSelectionStartTextPosition = OCMClassMock([UITextPosition class]);
        id mockSelectionEndTextPosition = OCMClassMock([UITextPosition class]);

        id mockTextField = OCMClassMock([UITextField class]);
        id mockSelectedTextRange = OCMClassMock([UITextRange class]);

        OCMStub([mockTextField beginningOfDocument]).andReturn(mockBeginningTextPosition);
        OCMStub([mockTextField selectedTextRange]).andReturn(mockSelectedTextRange);
        OCMStub([(UITextRange *)mockSelectedTextRange start]).andReturn(mockSelectionStartTextPosition);
        OCMStub([(UITextRange *)mockSelectedTextRange end]).andReturn(mockSelectionEndTextPosition);

        [[mockTextField expect] offsetFromPosition:mockBeginningTextPosition toPosition:mockSelectionStartTextPosition];
        [[mockTextField expect] offsetFromPosition:mockSelectionStartTextPosition toPosition:mockSelectionEndTextPosition];

        [mockTextField selectedNSRange];
    });
});

SpecEnd
