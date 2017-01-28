//
//  MvvmViewController.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 23/01/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import UIKit

open class MvvmViewController<Model> : UIViewController where Model: ViewControllerModel {

    open override func awakeFromNib() {
        super.awakeFromNib()
        self.view.translatesAutoresizingMaskIntoConstraints = false
    }

    public var viewModel: Model?
    public var dismissAction: (() -> Void)?

    internal var closeButton: UIButton? = .none
    @objc internal func closeButtonTapped(_ sender: UIButton) {
        if let action = dismissAction {
            action()
        }
    }

    var showCloseButton: Bool = false {
        didSet {
            if showCloseButton {
                doShowCloseButton()
            } else {
                doHideCloseButton()
            }
        }
    }
}
