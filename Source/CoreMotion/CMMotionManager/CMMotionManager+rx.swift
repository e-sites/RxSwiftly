//
//  CMMotionManager+rx.swift
//  CMMotionManager+rx.swift
//
//  Created by Bas van Kuijck on 26/07/2017.
//

import Foundation
import CoreMotion
import RxSwift
import RxCocoa

fileprivate var accelerationKey: UInt8 = 0

extension Reactive where Base: CMMotionManager {
    public var acceleration: Observable<CMAcceleration>? {

        /// The accelerometer could be unavailable in some cases
        if !self.base.isAccelerometerAvailable {
            return nil
        }

        /// Memoize this closure,
        /// because we don't want to create a different `RxSwift.Observable` for each `acceleration` variable call.
        /// See `Memoization.memoize` for more information about memoization in `CMMotionManager` instances
        return memoize(key: &accelerationKey) {
            Observable.create { observer in
                let motionManager = self.base

                let operationQueue = OperationQueue()
                operationQueue.qualityOfService = .utility
                operationQueue.maxConcurrentOperationCount = 1
                motionManager.deviceMotionUpdateInterval = 1.0 / 32.0 // 32 frames per second

                motionManager.startDeviceMotionUpdates(using: .xArbitraryZVertical, to: operationQueue) { motion, error in
                    OperationQueue.main.addOperation {
                        if let error = error {
                            observer.onError(error)

                        } else if let gravity = motion?.gravity {
                            observer.on(.next(gravity))
                        }
                    }
                }

                return Disposables.create {
                    motionManager.stopAccelerometerUpdates()
                }
            }.shareReplayLatestWhileConnected()
        }
    }
}
