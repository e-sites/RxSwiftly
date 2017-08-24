//
//  Observable+pairwise
//  RxSwiftly
//
//  Created by Bas van Kuijck on 28/07/2017.
//  Copyright © 2017 E-sites. All rights reserved.

import Foundation
import RxSwift
import RxCocoa

extension Observable {
    public func pairwise() -> Observable<(E, E)> {
        var previous: E? = nil
        return self
            .filter { element in
                if previous == nil {
                    previous = element
                    return false
                }
                return true
            }
            .map { (element: E) -> (E, E) in
                defer { previous = element }
                return (previous!, element)
            }
    }
}

