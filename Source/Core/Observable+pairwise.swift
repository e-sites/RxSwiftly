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
    /// Triggers on the second and subsequent triggerings of the input observable.
    /// The Nth triggering of the input observable passes the arguments from the N-1th and Nth triggering as a pair.
    ///
    /// - See: http://rxmarbles.com/#pairwise
    ///
    /// - Returns: `Observable`
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

