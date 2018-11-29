# UITextField+rx
> An extension to UITextField's rx

[![forthebadge](http://forthebadge.com/images/badges/made-with-swift.svg)](http://forthebadge.com) [![forthebadge](http://forthebadge.com/images/badges/approved-by-george-costanza.svg)](http://forthebadge.com) [![forthebadge](http://forthebadge.com/images/badges/uses-badges.svg)](http://forthebadge.com)

Compatible with:

- Swift 4.2
- RxSwift 4.4
- Xcode 10.1
- Cocoapods 1.6.0

## Usage

```swift
textField.rx.shouldReturn
	.subscribe(onNext: { _ in
	     // handle return key press
    }).addDisposableTo(disposeBag)
    
textField.rx.shouldClear
	.subscribe(onNext: { _ in
	     // handle clear button tap
    }).addDisposableTo(disposeBag)
```