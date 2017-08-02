//
//  NSObject+rx
//  RxSwiftly
//
//  Created by Bas van Kuijck on 28/07/2017.
//  Copyright © 2017 E-sites. All rights reserved.

import Foundation
import RxSwift
import RxCocoa

fileprivate var nsObjectAssociatedKey: UInt8 = 0

public extension NSObject {
    public var disposeBag: DisposeBag {
        return memoize(key: &nsObjectAssociatedKey) {
            DisposeBag()
        }
    }
}
