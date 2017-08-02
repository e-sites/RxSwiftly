# RxSwiflty
> An E-sites collection of RxSwift extensions created by the E-sites mobile development department.

[![forthebadge](http://forthebadge.com/images/badges/made-with-swift.svg)](http://forthebadge.com) [![forthebadge](http://forthebadge.com/images/badges/fuck-it-ship-it.svg)](http://forthebadge.com)

Compatible with:

- Swift 4
- RxSwift 4.0
- Xcode 9
- Cocoapods 1.3

## Collection

### 🎨 UIKit
▫️ [UIApplication](Source/UIKit/UIApplication/)

### 🏇 CoreMotion
▫️ [CMMotionManager](Source/CoreMotion/CMMotionManager/)

## Core

### NSObject+rx
> No need to declare a `DisposeBag`in every class.
 
```diff
class MyViewController: UIViewController {
-	let disposeBag = DisposeBag()
}
```

Every class that inherits from `NSObject` automatically adds a lazy variable `disposeBag`

### Memoization

> _[Wikipedia](https://en.wikipedia.org/wiki/Memoization): In computing, memoization or memoisation is an optimization technique used primarily to speed up computer programs by storing the results of expensive function calls and returning the cached result when the same inputs occur again._

[See source for more information](Source/Core/Memoization.swift)