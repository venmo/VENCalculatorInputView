#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <Specta/Specta.h>

#import "VENMoneyCalculator.h"

SpecBegin(VENMoneyCalculator)

describe(@"Evaluate expressions", ^{
    __block VENMoneyCalculator *moneyCalculator;

    beforeAll(^{
        moneyCalculator = [VENMoneyCalculator new];
        moneyCalculator.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    });

    it(@"should handle addition", ^{
        expect([moneyCalculator evaluateExpression:@"1+1"]).to.equal(@"2");
        expect([moneyCalculator evaluateExpression:@"1 + 1"]).to.equal(@"2");
        expect([moneyCalculator evaluateExpression:@"1 + 1000"]).to.equal(@"1001");
    });

    it(@"should handle subtraction", ^{
        expect([moneyCalculator evaluateExpression:@"1-1"]).to.equal(@"0");
        expect([moneyCalculator evaluateExpression:@"10000-1"]).to.equal(@"9999");
        expect([moneyCalculator evaluateExpression:@"0 - 100"]).to.equal(@"-100");
    });

    it(@"should handle multiplication", ^{
        expect([moneyCalculator evaluateExpression:@"2*2"]).to.equal(@"4");
        expect([moneyCalculator evaluateExpression:@"100*1.2"]).to.equal(@"120");
        expect([moneyCalculator evaluateExpression:@"1000 * 0.8"]).to.equal(@"800");
    });

    it(@"should handle division", ^{
        expect([moneyCalculator evaluateExpression:@"2/2"]).to.equal(@"1");
        expect([moneyCalculator evaluateExpression:@"100/4"]).to.equal(@"25");
        expect([moneyCalculator evaluateExpression:@"1/2"]).to.equal(@"0.50");
    });

    it(@"should return nil for invalid expressions", ^{
        expect([moneyCalculator evaluateExpression:@"1+++1"]).to.beNil();
        expect([moneyCalculator evaluateExpression:@"++++-12!@#"]).to.beNil();
        expect([moneyCalculator evaluateExpression:@"+"]).to.beNil();
        expect([moneyCalculator evaluateExpression:@"1+"]).to.beNil();
        expect([moneyCalculator evaluateExpression:@"2a"]).to.beNil();
        expect([moneyCalculator evaluateExpression:@"a2"]).to.beNil();
    });

    it(@"should handle − (longer dash)", ^{
        expect([moneyCalculator evaluateExpression:@"1−1"]).to.equal(@"0");
        expect([moneyCalculator evaluateExpression:@"10000−1"]).to.equal(@"9999");
        expect([moneyCalculator evaluateExpression:@"0 − 100"]).to.equal(@"-100");
    });

    it(@"should handle ×", ^{
        expect([moneyCalculator evaluateExpression:@"2×2"]).to.equal(@"4");
        expect([moneyCalculator evaluateExpression:@"100×1.2"]).to.equal(@"120");
        expect([moneyCalculator evaluateExpression:@"1000 × 0.8"]).to.equal(@"800");
    });

    it(@"should handle ÷", ^{
        expect([moneyCalculator evaluateExpression:@"2÷2"]).to.equal(@"1");
        expect([moneyCalculator evaluateExpression:@"100÷4"]).to.equal(@"25");
        expect([moneyCalculator evaluateExpression:@"1÷2"]).to.equal(@"0.50");
    });

    it(@"should handle ÷ 0", ^{
        expect([moneyCalculator evaluateExpression:@"2÷0"]).to.equal(@"0");
        expect([moneyCalculator evaluateExpression:@"0÷0"]).to.equal(@"0");
        expect([moneyCalculator evaluateExpression:@"-2÷0"]).to.equal(@"0");
        expect([moneyCalculator evaluateExpression:@"-0÷0"]).to.equal(@"0");
    });

});


describe(@"Handle other locale", ^{
    __block VENMoneyCalculator *moneyCalculator;

    beforeAll(^{
        moneyCalculator = [VENMoneyCalculator new];
        moneyCalculator.locale = [NSLocale localeWithLocaleIdentifier:@"fr_FR"];
    });

    it(@"should handle division", ^{
        expect([moneyCalculator evaluateExpression:@"2/2"]).to.equal(@"1");
        expect([moneyCalculator evaluateExpression:@"100/4"]).to.equal(@"25");
        expect([moneyCalculator evaluateExpression:@"1/2"]).to.equal(@"0,50");
    });

    it(@"should handle ×", ^{
        expect([moneyCalculator evaluateExpression:@"100×1,2"]).to.equal(@"120");
        expect([moneyCalculator evaluateExpression:@"1000 × 0,8"]).to.equal(@"800");
    });

});

SpecEnd