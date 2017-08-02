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

class RxApplicationDelegateProxy: DelegateProxy, DelegateProxyType, UIApplicationDelegate {
    public static var factory = DelegateProxyFactory { (parentObject: UIApplication) in
        RxApplicationDelegateProxy(parentObject: parentObject)
    }

    public class func setCurrentDelegate(_ delegate: AnyObject?, toObject object: AnyObject) {
        let application = object as! UIApplication
        application.delegate = delegate as? UIApplicationDelegate
    }

    public class func currentDelegateFor(_ object: AnyObject) -> AnyObject? {
        let application = object as! UIApplication
        return application.delegate
    }

    /// Exact copy of https://github.com/pixeldock/RxAppState
    /// Thanks to Jörn Schoppe <joern@pixeldock.com>
    ///
    /// This is an override to make sure that the original appDelegate is not deallocated
    ///
    /// Technically this creates a retain cycle. In this special case that is not a problem because UIApplication exists as long as the app exists anyway.
    ///
    /// It is necessary to retain the original AppDelegate because when RxApplicationDelegateProxy replaces the original delegate with the proxy it normally
    /// only keeps a weak reference to the original delegate to forward events to the original delegate.
    ///
    /// For other delegates this is the correct behaviour because other delegates usually are owned by another class (often a UIViewController).
    /// In case of the default app delegate it is different because there is no class that owns it. When the application is initialized the app delegate is
    /// explicitly initialized and allocated when UIApplicationMain() is called.
    /// Because of this the first app delegate is released when another object is set as app delegate
    ///
    /// And that makes it necessary to retain the orignal app delegate when the proxy is set as new delegate.
    ///
    /// Thanks to Michał Ciuba (https://twitter.com/MichalCiuba) who suggested this approach in his answer to my question on Stack Overflow:
    /// http://stackoverflow.com/questions/35575305/transform-uiapplicationdelegate-methods-into-rxswift-observables

    override func setForwardToDelegate(_ delegate: AnyObject?, retainDelegate: Bool) {
        super.setForwardToDelegate(delegate, retainDelegate: true)
    }
}
