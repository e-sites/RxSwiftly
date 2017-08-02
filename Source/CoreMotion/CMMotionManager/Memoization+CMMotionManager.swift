//
//  Memoization.swift
//  iBandPlus
//
//  Created by Bas van Kuijck on 28/07/2017.
//  Copyright © 2017 E-sites. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

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
    func memoize<T>(key: UnsafeRawPointer, lazyCreateClosure: () -> Observable<T>) -> Observable<T> {
        return memoize(self.base, key: key, lazyCreateClosure: lazyCreateClosure)
    }
}
