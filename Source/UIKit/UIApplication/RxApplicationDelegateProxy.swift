//
//  RxApplicationDelegateProxy.swift
//  UIApplicationState+rx
//
//  Created by Bas van Kuijck on 31/07/2017.
//  Copyright © 2017 E-sites. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class RxApplicationDelegateProxy:
    DelegateProxy<UIApplication, UIApplicationDelegate>,
    DelegateProxyType,
UIApplicationDelegate {
    
    static func registerKnownImplementations() {
        self.register { RxApplicationDelegateProxy(parentObject: $0) }
    }

    /// Typed parent object.
    public weak private(set) var application: UIApplication?

    /// - parameter parentObject: Parent object for delegate proxy.
    public init(parentObject: ParentObject) {
        self.application = parentObject
        super.init(parentObject: parentObject, delegateProxy: RxApplicationDelegateProxy.self)
    }

    open class func setCurrentDelegate(_ delegate: UIApplicationDelegate?, to object: ParentObject) {
        object.delegate = delegate
    }

    open class func currentDelegate(for object: ParentObject) -> UIApplicationDelegate? {
        return object.delegate
    }
}
