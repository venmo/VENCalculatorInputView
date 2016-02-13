#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <Specta/Specta.h>
#import <OCMock/OCMock.h>

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
    
    it(@"should handle long number", ^{
        expect([moneyCalculator evaluateExpression:@"123456*2"]).to.equal(@"246912");
        expect([moneyCalculator evaluateExpression:@"1234567*2"]).to.equal(@"2469134");
        expect([moneyCalculator evaluateExpression:@"12345678*2"]).to.equal(@"24691356");
        expect([moneyCalculator evaluateExpression:@"123456789*2"]).to.equal(@"246913578");
        expect([moneyCalculator evaluateExpression:@"1234567890*2"]).to.equal(@"2469135780");
        expect([moneyCalculator evaluateExpression:@"123456789*100"]).to.equal(@"12345678900");
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

describe(@"Handle Deutsch, which use . as grouping seperator", ^{
    __block VENMoneyCalculator *moneyCalculator;

    beforeAll(^{
        moneyCalculator = [VENMoneyCalculator new];
        moneyCalculator.locale = [NSLocale localeWithLocaleIdentifier:@"de_DE"];
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

    it(@"should handle big numbers", ^{
        expect([moneyCalculator evaluateExpression:@"1.035,01+40"]).to.equal(@"1.075,01");
        expect([moneyCalculator evaluateExpression:@"1.040,01-1.035"]).to.equal(@"5,01");
    });

});

describe(@"locale", ^{
    __block VENMoneyCalculator *moneyCalculator;
    __block id mockLocale;

    beforeAll(^{
        mockLocale = [OCMockObject mockForClass:[NSLocale class]];
        [[[mockLocale stub] andReturn:[NSLocale localeWithLocaleIdentifier:@"vi_VN"]] currentLocale];
        moneyCalculator = [VENMoneyCalculator new];
    });

    afterAll(^{
        [mockLocale stopMocking];
    });

    it(@"should use the current locale by default (Vietname in this case)", ^{
        expect([moneyCalculator evaluateExpression:@"1,90"]).to.equal(@"2");
        expect([moneyCalculator evaluateExpression:@"1,30"]).to.equal(@"1");
        expect([moneyCalculator evaluateExpression:@"0,90"]).to.equal(@"1");
    });

    it(@"should use the specified locale if set", ^{
        moneyCalculator.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
        expect([moneyCalculator evaluateExpression:@"1.9"]).to.equal(@"1.90");
        expect([moneyCalculator evaluateExpression:@"1.30"]).to.equal(@"1.30");
        expect([moneyCalculator evaluateExpression:@"0.90"]).to.equal(@"0.90");
    });
});

SpecEnd