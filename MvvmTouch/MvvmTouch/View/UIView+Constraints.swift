//
//  UIView+Constraints.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 16/07/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import UIKit

public extension UIView {
    public func makeFillViewConstraints(_ subView: UIView) -> [NSLayoutConstraint] {
        let allConstraints = [
            subView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            subView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            subView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            subView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ]

        allConstraints.forEach { $0.isActive = true }

        return allConstraints
    }

    public func addAndFillWithSubView(_ subView: UIView) {
        addSubview(subView)
        addConstraints(makeFillViewConstraints(subView))
    }
}
