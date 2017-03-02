//
//  UViewController+Constraints.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 02/03/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import UIKit

extension UIViewController {

    func makeFillViewConstraints(subView: UIView) -> [NSLayoutConstraint] {
        let top = view.topAnchor
        let bottom = view.bottomAnchor

        let margins = view.layoutMarginsGuide
        let allConstraints = [
            subView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            subView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor),
            subView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            subView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        ]

        allConstraints.forEach{ $0.isActive = true }

        return allConstraints
    }

}
