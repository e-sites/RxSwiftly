//
//  Memoization.swift
//  iBandPlus
//
//  Created by Bas van Kuijck on 28/07/2017.
//  Copyright © 2017 E-sites. All rights reserved.
//

import Foundation

public protocol Memozation: class { }
extension NSObject: Memozation { }

extension Memozation {
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
        return memoize(self, key: key, lazyCreateClosure: lazyCreateClosure)
    }
}

public func memoize<T>(_ obj: Any, key: UnsafeRawPointer, lazyCreateClosure: () -> T) -> T {
    objc_sync_enter(obj); defer { objc_sync_exit(obj) }
    if let object = objc_getAssociatedObject(obj, key) as? T {
        return object
    }

    let object = lazyCreateClosure()
    objc_setAssociatedObject(obj, key, object, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    return object
}
