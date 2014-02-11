#import <UIKit/UIKit.h>

@class VENCalculatorInputView;
@protocol VENCalculatorInputViewDelegate <NSObject>

@optional
- (void)calculatorInputView:(VENCalculatorInputView *)inputView didTapKey:(NSString *)key;
- (void)calculatorInputViewDidTapBackspace:(VENCalculatorInputView *)calculatorInputView;

@end

@interface VENCalculatorInputView : UIView <UIInputViewAudioFeedback>

@property (weak, nonatomic) id<VENCalculatorInputViewDelegate> delegate;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberButtonCollection;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *operationButtonCollection;

@end
