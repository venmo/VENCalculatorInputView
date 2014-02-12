#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <Specta/Specta.h>

#import "VENCalculator.h"

SpecBegin(VENCalculator)

describe(@"Evaluate expressions", ^{

    it(@"should handle addition", ^{
        expect([VENCalculator evaluateExpression:@"1+1"]).to.equal(@"2");
        expect([VENCalculator evaluateExpression:@"1 + 1"]).to.equal(@"2");
        expect([VENCalculator evaluateExpression:@"1 + 1000"]).to.equal(@"1001");
    });

    it(@"should handle subtraction", ^{
        expect([VENCalculator evaluateExpression:@"1-1"]).to.equal(@"0");
        expect([VENCalculator evaluateExpression:@"10000-1"]).to.equal(@"9999");
        expect([VENCalculator evaluateExpression:@"0 - 100"]).to.equal(@"-100");
    });

    it(@"should handle multiplication", ^{
        expect([VENCalculator evaluateExpression:@"2*2"]).to.equal(@"4");
        expect([VENCalculator evaluateExpression:@"100*1.2"]).to.equal(@"120");
        expect([VENCalculator evaluateExpression:@"1000 * 0.8"]).to.equal(@"800");
    });

    it(@"should handle division", ^{
        expect([VENCalculator evaluateExpression:@"2/2"]).to.equal(@"1");
        expect([VENCalculator evaluateExpression:@"100/4"]).to.equal(@"25");
        expect([VENCalculator evaluateExpression:@"1/2"]).to.equal(@"0.50");
    });

    it(@"should return nil for invalid expressions", ^{
        expect([VENCalculator evaluateExpression:@"1+++1"]).to.beNil();
        expect([VENCalculator evaluateExpression:@"++++-12!@#"]).to.beNil();
        expect([VENCalculator evaluateExpression:@"+"]).to.beNil();
        expect([VENCalculator evaluateExpression:@"1+"]).to.beNil();
    });
    
});

SpecEnd
