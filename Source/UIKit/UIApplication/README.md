# UIApplicationState+rx
> A small class to make UIApplication's applicationState rx compatible

[![forthebadge](http://forthebadge.com/images/badges/made-with-swift.svg)](http://forthebadge.com) [![forthebadge](http://forthebadge.com/images/badges/approved-by-george-costanza.svg)](http://forthebadge.com) [![forthebadge](http://forthebadge.com/images/badges/uses-badges.svg)](http://forthebadge.com)

Compatible with:

- Swift 4
- RxSwift 4.0
- Xcode 9
- Cocoapods 1.3

## Usage

```swift
UIApplication.shared.rx.applicationState
	.subscribe { event in
	   // event.element = UIApplicationState
	}.addDisposableTo(disposeBag)
```