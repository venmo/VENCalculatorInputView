#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <Specta/Specta.h>

#import "VENMoneyCalculator.h"

SpecBegin(VENMoneyCalculator)

describe(@"Evaluate expressions", ^{

    it(@"should handle addition", ^{
        expect([VENMoneyCalculator evaluateExpression:@"1+1"]).to.equal(@"2");
        expect([VENMoneyCalculator evaluateExpression:@"1 + 1"]).to.equal(@"2");
        expect([VENMoneyCalculator evaluateExpression:@"1 + 1000"]).to.equal(@"1001");
    });

    it(@"should handle subtraction", ^{
        expect([VENMoneyCalculator evaluateExpression:@"1-1"]).to.equal(@"0");
        expect([VENMoneyCalculator evaluateExpression:@"10000-1"]).to.equal(@"9999");
        expect([VENMoneyCalculator evaluateExpression:@"0 - 100"]).to.equal(@"-100");
    });

    it(@"should handle multiplication", ^{
        expect([VENMoneyCalculator evaluateExpression:@"2*2"]).to.equal(@"4");
        expect([VENMoneyCalculator evaluateExpression:@"100*1.2"]).to.equal(@"120");
        expect([VENMoneyCalculator evaluateExpression:@"1000 * 0.8"]).to.equal(@"800");
    });

    it(@"should handle division", ^{
        expect([VENMoneyCalculator evaluateExpression:@"2/2"]).to.equal(@"1");
        expect([VENMoneyCalculator evaluateExpression:@"100/4"]).to.equal(@"25");
        expect([VENMoneyCalculator evaluateExpression:@"1/2"]).to.equal(@"0.50");
    });

    it(@"should return nil for invalid expressions", ^{
        expect([VENMoneyCalculator evaluateExpression:@"1+++1"]).to.beNil();
        expect([VENMoneyCalculator evaluateExpression:@"++++-12!@#"]).to.beNil();
        expect([VENMoneyCalculator evaluateExpression:@"+"]).to.beNil();
        expect([VENMoneyCalculator evaluateExpression:@"1+"]).to.beNil();
    });

    it(@"should handle − (longer dash)", ^{
        expect([VENMoneyCalculator evaluateExpression:@"1−1"]).to.equal(@"0");
        expect([VENMoneyCalculator evaluateExpression:@"10000−1"]).to.equal(@"9999");
        expect([VENMoneyCalculator evaluateExpression:@"0 − 100"]).to.equal(@"-100");
    });

    it(@"should handle ×", ^{
        expect([VENMoneyCalculator evaluateExpression:@"2×2"]).to.equal(@"4");
        expect([VENMoneyCalculator evaluateExpression:@"100×1.2"]).to.equal(@"120");
        expect([VENMoneyCalculator evaluateExpression:@"1000 × 0.8"]).to.equal(@"800");
    });

    it(@"should handle ÷", ^{
        expect([VENMoneyCalculator evaluateExpression:@"2÷2"]).to.equal(@"1");
        expect([VENMoneyCalculator evaluateExpression:@"100÷4"]).to.equal(@"25");
        expect([VENMoneyCalculator evaluateExpression:@"1÷2"]).to.equal(@"0.50");
    });

    it(@"should handle ÷ 0", ^{
        expect([VENMoneyCalculator evaluateExpression:@"2÷0"]).to.equal(@"0");
        expect([VENMoneyCalculator evaluateExpression:@"0÷0"]).to.equal(@"0");
        expect([VENMoneyCalculator evaluateExpression:@"-2÷0"]).to.equal(@"0");
        expect([VENMoneyCalculator evaluateExpression:@"-0÷0"]).to.equal(@"0");
    });

});

SpecEnd