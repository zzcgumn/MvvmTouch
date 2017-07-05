//
//  MvvmViewController+Buttons.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 28/01/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import Foundation

extension MvvmViewController {

    open func makeCloseButton() -> UIButton {
        let button = UIButton(type: .system)

        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)

        button.setTitle("Close", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setContentHuggingPriority(UILayoutPriority(rawValue: 1.0), for: .vertical)
        button.setContentHuggingPriority(UILayoutPriority(rawValue: 1.0), for: .horizontal)
        button.setTitleColor(UIColor.blue, for: .normal)
        self.view.addSubview(button)
        let topConstraint = NSLayoutConstraint(item: button,
                                               attribute: .topMargin,
                                               relatedBy: .equal,
                                               toItem: self.view,
                                               attribute: .top,
                                               multiplier: 1.0,
                                               constant: 28.0)

        let leftConstraint = NSLayoutConstraint(item: button,
                                                attribute: .leftMargin,
                                                relatedBy: .equal,
                                                toItem: self.view,
                                                attribute: .left,
                                                multiplier: 1.0,
                                                constant: 28.0)

        self.view.addConstraint(topConstraint)
        self.view.addConstraint(leftConstraint)

        return button
    }

    internal func doShowCloseButton() {
        if closeButton == .none {
            closeButton = makeCloseButton()
        }

        closeButton?.isHidden = false
        closeButton?.isEnabled = true
    }

    internal func doHideCloseButton() {
        guard let button = closeButton else {
            return
        }

        button.isHidden = true
        button.removeFromSuperview()
        closeButton = .none
    }
}
