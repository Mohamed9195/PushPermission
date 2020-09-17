//
//  PushPermission.swift
//  PushPermission
//
//  Created by mohamed hashem on 9/17/20.
//  Copyright © 2020 mohamed hashem. All rights reserved.
//

import UIKit

open class NibView : UIView {
    var view: UIView = UIView()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
}

private extension NibView {
    func xibSetup() {
        backgroundColor = UIColor.clear
        view = loadNib()
        view.frame = bounds
        addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view]))
    }
}

public extension UIView {
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "PushPermission", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}

open class PushPermission: NibView {

}
