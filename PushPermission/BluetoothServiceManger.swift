//
//  BluetoothServiceManger.swift
//  PushPermission
//
//  Created by mohamed hashem on 9/18/20.
//  Copyright © 2020 mohamed hashem. All rights reserved.
//


import CoreBluetooth
import RxSwift
import RxCocoa

class BluetoothManager {
    let stateSubject = ReplaySubject<ServiceStatus>.create(bufferSize: 1)
    fileprivate let bluetoothCentralManager = CBCentralManager()
    fileprivate let disposeBag = DisposeBag()

    init() {
        bluetoothCentralManager
            .rx
            .didUpdateState
            .startWith(bluetoothCentralManager.state.serviceStatus)
            .bind(to: stateSubject)
            .disposed(by: disposeBag)
    }
}

extension CBCentralManager: HasDelegate {
    public typealias Delegate = CBCentralManagerDelegate
}

private class RxBluetoothManagerDelegateProxy: DelegateProxy<CBCentralManager, CBCentralManagerDelegate>,
    DelegateProxyType,
    CBCentralManagerDelegate {

    fileprivate let didUpdateState = ReplaySubject<CBManagerState>.create(bufferSize: 1)

    public init(bluetoothManager: ParentObject) {
        didUpdateState.onNext(bluetoothManager.state)
        super.init(parentObject: bluetoothManager, delegateProxy: RxBluetoothManagerDelegateProxy.self)
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        didUpdateState.onNext(central.state)
    }

    deinit {
        didUpdateState.onCompleted()
    }

    static func registerKnownImplementations() {
        register { RxBluetoothManagerDelegateProxy(bluetoothManager: $0) }
    }
}

fileprivate extension Reactive where Base: CBCentralManager {
    typealias DidUpdateState = (ServiceStatus)

    var delegate: RxBluetoothManagerDelegateProxy {
        return RxBluetoothManagerDelegateProxy.proxy(for: base)
    }

    var didUpdateState: ControlEvent<DidUpdateState> {
        let source: Observable<DidUpdateState> = delegate.didUpdateState
            .map { $0.serviceStatus }
        return ControlEvent(events: source)
    }
}

fileprivate extension CBManagerState {
    var serviceStatus: ServiceStatus {
        switch self {
        case .resetting, .unknown, .unsupported:
            return ServiceStatus.unknown

        case .unauthorized:
            return ServiceStatus.notAuthorized

        case .poweredOff:
            return ServiceStatus.disabled

        case .poweredOn:
            return ServiceStatus.enabled

        @unknown default:
            return ServiceStatus.unknown
        }
    }
}

