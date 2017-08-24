# RxSwiflty
> An E-sites collection of RxSwift extensions created by the E-sites mobile development department.

[![forthebadge](http://forthebadge.com/images/badges/made-with-swift.svg)](http://forthebadge.com) [![forthebadge](http://forthebadge.com/images/badges/fuck-it-ship-it.svg)](http://forthebadge.com)

Compatible with:

- Swift 4
- RxSwift 4.0
- Xcode 9
- Cocoapods 1.3

## Installation
### `Podfile`
```ruby
pod 'RxSwiftly/<Framework>/<Class>'
```

See [Collection](#collection) for an overview of all the frameworks and its subspecs

```ruby
target 'Project' do
    pod 'RxSwift', :git => 'git@github.com:ReactiveX/RxSwift.git', :branch => 'swift4.0'
    pod 'RxCocoa', :git => 'git@github.com:ReactiveX/RxSwift.git', :branch => 'swift4.0'

    # RxSwiftly
    pod 'RxSwiftly/UIKit/UIApplication'
    pod 'RxSwiftly/CoreMotion/CMMotionManager'
end

post_install do |installer|
    swift4_targets = [ "RxSwift", "RxCocoa", "RxSwiftly" ]
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            if swift4_targets.include? target.name
                config.build_settings['SWIFT_VERSION'] = '4.0'
            end
        end
    end
end

```

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

### Observable+pairwise
> See [RxMarbles.com#pairwise](http://rxmarbles.com/#pairwise) for more information
 
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