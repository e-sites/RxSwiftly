//
//  RxTextFieldDelegateProxy.swift
//
//  Created by Lex Tang on 2/14/18.
//  Copyright © 2018 Krunoslav Zaher. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

open class RxTextFieldDelegateProxy: DelegateProxy<UITextField, UITextFieldDelegate>, DelegateProxyType, UITextFieldDelegate {

    public static func currentDelegate(for object: UITextField) -> UITextFieldDelegate? {
        return object.delegate
    }

    public static func setCurrentDelegate(_ delegate: UITextFieldDelegate?, to object: UITextField) {
        object.delegate = delegate
    }

    /// Typed parent object.
    public weak private(set) var textField: UITextField?

    /// - parameter textfield: Parent object for delegate proxy.
    public init(textField: ParentObject) {
        self.textField = textField
        super.init(parentObject: textField, delegateProxy: RxTextFieldDelegateProxy.self)
    }

    // Register known implementations
    public static func registerKnownImplementations() {
        register(make: RxTextFieldDelegateProxy.init)
    }

    // MARK: delegate methods
    /// For more information take a look at `DelegateProxyType`.
    @objc
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return forwardToDelegate()?.textFieldShouldReturn?(textField) ?? true
    }

    @objc
    open func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return forwardToDelegate()?.textFieldShouldClear?(textField) ?? true
    }
}
