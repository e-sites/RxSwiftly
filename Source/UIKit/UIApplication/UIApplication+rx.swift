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

fileprivate var applicationStateKey: UInt8 = 0

extension Reactive where Base: UIApplication {
    /// Observable sequence of the application's state
    ///
    /// This gives you an observable sequence of all possible application states.
    ///
    /// - Warning:
    /// Setting up a Rx KVO on "applicationState" will not work, whereas `applicationState` is not KVO compliant.
    /// That's why we set use a NotificationCenter
    ///
    /// - Returns: Observable sequence of `UIApplicationState`s
    public var applicationState: Observable<UIApplication.State> {
        return memoize(key: &applicationStateKey) {
            let observables = [
                UIApplication.didBecomeActiveNotification,
                UIApplication.didEnterBackgroundNotification,
                UIApplication.willEnterForegroundNotification,
                UIApplication.didFinishLaunchingNotification,
                UIApplication.willResignActiveNotification,
                UIApplication.willTerminateNotification
                ].compactMap {
                    NotificationCenter.default.rx.notification($0)
            }

            return Observable<Notification>.merge(observables)
                .map { _ in UIApplication.shared.applicationState }
                .distinctUntilChanged()
        }
    }
}
