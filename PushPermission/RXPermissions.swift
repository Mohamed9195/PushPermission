//
//  RXPermissions.swift
//  PushPermission
//
//  Created by mohamed hashem on 9/17/20.
//  Copyright © 2020 mohamed hashem. All rights reserved.
//

import RxSwift
import RxCocoa

enum Service {
    case bluetooth
    case notification
    case location
    case camera
    case photoLibrary
}

enum ServiceStatus {
    case enabled
    case disabled
    case notAuthorized
    case unknown
}

open class RXPermissions {

    private let userNotificationServiceManager = UserNotificationManager()
    private let locationServiceManager = LocationManager()
    private let bluetoothServiceManager = BluetoothManager()
    private let photoLibraryServiceManager = PhotoLibraryManager()
    private let cameraServiceManager = CameraManager()

    func observe(services: Service...) -> Observable<(service: Service, status: ServiceStatus)> {

        var observables = [Observable<(service: Service, status: ServiceStatus)>]()

        services.forEach { (service) in
            switch service {
            case .bluetooth:
                let observable = bluetoothServiceManager
                    .stateSubject
                    .asObservable()
                    .distinctUntilChanged()
                observables.append(observable.map { (service: .bluetooth, status: $0) })
            case .notification:
                let observable = userNotificationServiceManager
                    .stateSubject
                    .asObservable()
                    .distinctUntilChanged()
                observables.append(observable.map { (service: .notification, status: $0) })
            case .location:
                let observable = locationServiceManager
                    .stateSubject
                    .asObservable()
                    .distinctUntilChanged()
                observables.append(observable.map { (service: .location, status: $0) })
            case .camera:
                let observable = cameraServiceManager
                    .stateSubject
                    .asObservable()
                    .distinctUntilChanged()
                observables.append(observable.map { (service: .location, status: $0) })
            case .photoLibrary:
                let observable = photoLibraryServiceManager
                    .stateSubject
                    .asObservable()
                    .distinctUntilChanged()
                observables.append(observable.map { (service: .location, status: $0) })
            }
        }
        return Observable.merge(observables)
    }
}
