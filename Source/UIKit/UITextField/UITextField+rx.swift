//
//  UITextField+Rx.swift
//
//  Created by Lex Tang on 2/14/18.
//  Copyright © 2018 Krunoslav Zaher. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa

extension UITextField {

    /// Factory method that enables subclasses to implement their own `delegate`.
    ///
    /// - returns: Instance of delegate proxy that wraps `delegate`.
    public func createRxDelegateProxy() -> RxTextFieldDelegateProxy {
        return RxTextFieldDelegateProxy(textField: self)
    }
}

extension Reactive where Base: UITextField {

    /// Reactive wrapper for `delegate`.
    ///
    /// For more information take a look at `DelegateProxyType` protocol documentation.
    public var delegate: DelegateProxy<UITextField, UITextFieldDelegate> {
        return RxTextFieldDelegateProxy.proxy(for: base)
    }

    /// Reactive wrapper for `delegate` message.
    public var shouldReturn: ControlEvent<Void> {
        let source = delegate.rx.methodInvoked(#selector(UITextFieldDelegate.textFieldShouldReturn))
            .map { _ in }

        return ControlEvent(events: source)
    }

    public var shouldClear: ControlEvent<Void> {
        let source = delegate.rx.methodInvoked(#selector(UITextFieldDelegate.textFieldShouldClear))
            .map { _ in }

        return ControlEvent(events: source)
    }
}
