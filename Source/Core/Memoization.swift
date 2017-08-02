//
//  Memoization.swift
//  RxSwiftly
//
//  Created by Bas van Kuijck on 28/07/2017.
//  Copyright © 2017 E-sites. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public protocol Memoization: class { }
extension NSObject: Memoization { }

extension Memoization {
    /// Memoizes the the `lazyCreateClosure`
    ///
    /// [Read this](https://nl.wikipedia.org/wiki/Memoization) for more information about memoization:
    ///
    /// - Notes: Memoization will be stored alongside the &key and the `self`.
    ///
    /// - Parameters:
    ///   - key: The `UnsafeRawPointer` to store the memoized outcome in.
    ///   - lazyCreateClosure: The closure which creates the object
    /// - Returns: The object itself
    public func memoize<T>(key: UnsafeRawPointer, lazyCreateClosure: () -> T) -> T {
        return _memoize(self, key: key, lazyCreateClosure: lazyCreateClosure)
    }
}

extension Reactive {
    /// Memoizes the the `lazyCreateClosure`
    ///
    /// [Read this](https://nl.wikipedia.org/wiki/Memoization) for more information about memoization:
    ///
    /// - Notes: Memoization will be stored alongside the &key and the `self.base` of the Reactive instance.
    ///
    /// - Parameters:
    ///   - key: The `UnsafeRawPointer` to store the memoized outcome in.
    ///   - lazyCreateClosure: The closure which creates the object
    /// - Returns: The object itself
    public func memoize<T>(key: UnsafeRawPointer, lazyCreateClosure: () -> Observable<T>) -> Observable<T> {
        return _memoize(self.base, key: key, lazyCreateClosure: lazyCreateClosure)
    }
}

fileprivate func _memoize<T>(_ object: Any, key: UnsafeRawPointer, lazyCreateClosure: () -> T) -> T {
    objc_sync_enter(object); defer { objc_sync_exit(object) }
    if let instance = objc_getAssociatedObject(object, key) as? T {
        return instance
    }

    let instance = lazyCreateClosure()
    objc_setAssociatedObject(object, key, instance, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    return instance
}

