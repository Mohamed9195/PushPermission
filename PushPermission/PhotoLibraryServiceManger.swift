//
//  PhotoLibraryServiceManger.swift
//  PushPermission
//
//  Created by mohamed hashem on 9/18/20.
//  Copyright © 2020 mohamed hashem. All rights reserved.
//

import Photos
import RxSwift
import RxCocoa

class PhotoLibraryManager {
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
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            self.stateSubject.onNext(.enabled)

        case .denied, .restricted :
            self.stateSubject.onNext(.notAuthorized)

        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized:
                    self.stateSubject.onNext(.enabled)

                case .denied, .restricted:
                    self.stateSubject.onNext(.notAuthorized)

                case .notDetermined:
                    self.stateSubject.onNext(.disabled)

                @unknown default:
                    self.stateSubject.onNext(.unknown)
                }
            }
        @unknown default:
             self.stateSubject.onNext(.unknown)
        }
    }
}


