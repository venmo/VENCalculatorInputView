VENCalculatorInputView
=========

[![Build Status](https://travis-ci.org/venmo/VENCalculatorInputView.svg?branch=master)](https://travis-ci.org/venmo/VENCalculatorInputView)

VENCalculatorInputView is the calculator keyboard that is used in the [Venmo](https://venmo.com/) iOS app.
Available for iOS 6 and beyond. Enjoy.

<p align="center">
<img src="http://i.imgur.com/VWgymjH.gif" alt="VENCalculatorInputView demo"/>
</p>
Installation
----

The easiest way to get started is to use [CocoaPods](http://cocoapods.org/). Just add the following line to your Podfile:

```ruby
pod 'VENCalculatorInputView', '~> 1.5'
```

Sample Usage
----
You can choose to use ```VENCalculatorInputView``` and define your own calculation behavior or use ```VENCalculatorInputTextField``` for both keyboard and calculation.

### Use the calculator text field (recommended)

All you need to do is use ```VENCalculatorInputTextField``` instead of ```UITextField``` and treat it like a normal text field. It will automagically handle the input and make calculations. Take a look at out our [VENCalculatorInputViewSample](https://github.com/venmo/VENCalculatorInputView/tree/master/VENCalculatorInputViewSample) project to see how easy it is.

### Use only the calculator keyboard

#### 1. Set the input view.
Find the ```UITextField``` or ```UITextView``` that you want to display the keyboard and set its ```inputView``` to an instance of ```VENCalculatorInputView```.

```obj-c
myTextField.inputView = [VENCalculatorInputView new];
```

This will have ```VENCalculatorInputView``` display when ```myTextField``` becomes ```firstResponder``` instead of the system keyboard.

#### 2. Implement the ```<VENCalculatorInputViewDelegate>``` methods.

Have a class implement the ```<VENCalculatorInputViewDelegate>``` protocol and set ```myTextField.inputView.delegate``` to an instance of that class.

Implement the delegate method that handles keyboard input:

```obj-c
- (void)calculatorInputView:(VENCalculatorInputView *)inputView didTapKey:(NSString *)key {
    NSLog(@"Just tapped key: %@", key);
    // Handle the input. Something like [myTextField insertText:key];
}
```

Implement the delegate method that handles the backspace key:

```obj-c
- (void)calculatorInputViewDidTapBackspace:(VENCalculatorInputView *)calculatorInputView {
    NSLog(@"Just tapped backspace.");
    // Handle the backspace. Something like [myTextField deleteBackward];
}
```

You can read more about custom keyboards in [Apple’s documentation](https://developer.apple.com/library/ios/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/InputViews/InputViews.html).

Localization
------

Different regions use different symbols as their decimal separator (e.g. ```.```, ```,```). By default, ```VENCalculatorInputView``` and ```VENCalculatorInputTextField``` use the current locale of the device. You can change it by setting the ```locale``` property.

Testing
------

Run example tests in this repo by opening the project in Xcode and hitting `Command-U`.

Contributing
------------

We’d love to see your ideas for improving this library! The best way to contribute is by submitting a pull request. We’ll do our best to respond to your patch as soon as possible. You can also submit a [new GitHub issue](https://github.com/venmo/VENCalculatorInputView/issues/new) if you find bugs or have questions. :octocat:

Please make sure to follow our general coding style and add test coverage for new features!
