# PushPermission
using push protocol to get any update in permissions when calling framework objects one time using RXSwift with RXCocoa, and can use Push RXPermission View to show all permission. 

# Installation
pod 'PushPermission', :git => 'https://github.com/Mohamed9195/PushPermission.git', :tag => '0.0.5'

# authors     
 Mohamed Hashem mohamedabdalwahab588@gmail.com

# Note
 when calling RXPermissions one time you will get any change in permission automatically.
 
# example
```swift
import PushPermission

let serviceStatusManager: RXPermissions = RXPermissions()

serviceStatusManager.observe(services: .bluetooth, .camera, .location, .notification, .photoLibrary)
// or serviceStatusManager.observe(services: .bluetooth) add any permission you need use it
            .debug("serviceStatusManager")
            .subscribe(onNext: { (output: (service: Service, status: ServiceStatus)) in
                switch output.service {
                case .bluetooth:
                    print("show bluetooth status", output.status)
                case .notification:
                    print("show notification status", output.status)
                case .location:
                    print("show location status", output.status)
                case .camera:
                    print("show camera status", output.status)
                case .photoLibrary:
                    print("show photoLibrary status", output.status)
                }

// or can use this
                switch output {
                case (let service, let status):
                    print("service is:", service, "status is:", status )
                }
            }).disposed(by: disposeBag)
