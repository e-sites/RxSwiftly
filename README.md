# RxSwiflty
> An E-sites collection of RxSwift extensions created by the E-sites mobile development department.

[![forthebadge](http://forthebadge.com/images/badges/made-with-swift.svg)](http://forthebadge.com) [![forthebadge](http://forthebadge.com/images/badges/fuck-it-ship-it.svg)](http://forthebadge.com)

Compatible with:

- Swift 4.2
- RxSwift 4.4.0
- Xcode 10.1
- Cocoapods 1.6.0

## Installation
### `Podfile`
```ruby
pod 'RxSwiftly/<Framework>/<Class>'
```

See [Collection](#collection) for an overview of all the frameworks and its subspecs

```ruby
target 'Project' do
    # RxSwiftly
    pod 'RxSwiftly/UIKit/UIApplication'
    pod 'RxSwiftly/UIKit/UITextField'
    pod 'RxSwiftly/CoreMotion/CMMotionManager'
end
```

## Collection

### 🎨 UIKit
▫️ [UIApplication](Source/UIKit/UIApplication/)    
▫️ [UITextField](Source/UIKit/UITextField/) (Thanks to [lexrus](https://gist.github.com/lexrus))

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

### Observable.pairwise()
> _Triggers on the second and subsequent triggerings of the input observable.    
> The Nth triggering of the input observable passes the arguments from the N-1th and Nth triggering as a pair._

See [RxMarbles.com#pairwise](http://rxmarbles.com/#pairwise) for more information
 
```swift
User.current.rx.state
    .pairwise()
    .filter { $0.0 == .loggedIn && $0.1 == .loggedOut }
    .subscribe { _ in
        logger.warning("User logged out!")
    }
.addDisposableTo(disposeBag)
```

Improvement over the `Observable.zip(sequence.skip(1), sequence)`