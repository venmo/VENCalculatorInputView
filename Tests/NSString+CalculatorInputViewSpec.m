#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <Specta/Specta.h>

#import "NSString+CalculatorInputView.h"

SpecBegin(NSString_CalculatorInputView)

describe(@"ven_stringByReplacingCharactersInSet:withString:", ^{

    it(@"should handle whitespace characters", ^{
        NSString *s = @"foo     bar\n           ";
        NSString *result = [s ven_stringByReplacingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] withString:@""];
        expect(result).to.equal(@"foobar");
    });

    it(@"should handle custom NSCharacterSet", ^{
        NSString *s = @"1+1(&^!@#+1foobar";
        NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789-/*.+"] invertedSet];
        NSString *result = [s ven_stringByReplacingCharactersInSet:characterSet withString:@""];
        expect(result).to.equal(@"1+1+1");
    });
});

SpecEnd