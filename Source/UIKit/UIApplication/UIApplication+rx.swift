//
//  UIApplication+rx.swift
//  UIApplication+rx
//
//  Created by Bas van Kuijck on 31/07/2017.
//  Copyright © 2017 E-sites. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

extension Reactive where Base: UIApplication {
    public var delegate: DelegateProxy {
        return RxApplicationDelegateProxy.proxyForObject(base)
    }
    
    /// Observable sequence of the application's state
    ///
    /// This gives you an observable sequence of all possible application states.
    ///
    /// - Warning:
    /// Setting up a Rx KVO on "applicationState" will not work, whereas `applicationState` is not KVO compliant.      
    /// That's why we set up a `RxApplicationDelegateProxy` to handle the state changes.
    ///
    /// - Returns: Observable sequence of `UIApplicationState`s
    public var applicationState: Observable<UIApplicationState> {
        return Observable.of(
            _invokeMap(#selector(UIApplicationDelegate.applicationDidBecomeActive(_:)), .active),
            _invokeMap(#selector(UIApplicationDelegate.applicationDidEnterBackground(_:)), .background),
            _invokeMap(#selector(UIApplicationDelegate.applicationWillResignActive(_:)), .inactive)
            )
            .merge()
    }

    private func _invokeMap(_ selector: Selector, _ state: UIApplicationState) -> Observable<UIApplicationState> {
        return delegate
            .methodInvoked(selector)
            .map { _ in
                return state
            }
    }
}
