//
//  CameraServiceManger.swift
//  PushPermission
//
//  Created by mohamed hashem on 9/18/20.
//  Copyright © 2020 mohamed hashem. All rights reserved.
//

import RxSwift
import RxCocoa
import Photos

class CameraManager {
    let stateSubject = ReplaySubject<ServiceStatus>.create(bufferSize: 1)

    init() {
        checkStatus()

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(checkStatus), name: UIApplication.willEnterForegroundNotification, object: nil)
    }

    deinit {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }

    @objc fileprivate func checkStatus() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            self.stateSubject.onNext(.enabled)

        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                   self.stateSubject.onNext(.enabled)
                } else {
                    self.stateSubject.onNext(.disabled)
                }
            }

        case .denied:
            self.stateSubject.onNext(.notAuthorized)

        case .restricted:
            self.stateSubject.onNext(.notAuthorized)

        @unknown default:
            self.stateSubject.onNext(.unknown)
        }
    }
}
