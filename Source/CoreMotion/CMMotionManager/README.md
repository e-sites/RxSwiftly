# CMMotionManager+rx
> A small class to get the `accelation` from a `CMMotionManager` instance

[![forthebadge](http://forthebadge.com/images/badges/made-with-swift.svg)](http://forthebadge.com) [![forthebadge](http://forthebadge.com/images/badges/does-not-contain-treenuts.svg)](http://forthebadge.com)

Compatible with:

- Swift 4
- RxSwift 4.0
- Xcode 9
- Cocoapods 1.3

> ⚠️ Uses `memozation` internally. [Read more about memoization here](../../Core/Memoization.swift).

## Usage

```swift
let motionManager = CMMotionManager()
        
motionManager.rx.acceleration?
    .subscribe { event in
        // event.element = CMAcceleration?
    }.addDisposableTo(disposeBag)
```
