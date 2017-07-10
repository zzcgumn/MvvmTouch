//
//  MvvmViewController.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 23/01/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import UIKit

protocol MvvmViewControllerProtocol {
    associatedtype Model: ViewControllerModel
    var viewModel: Model? { get set }
    var dismissAction: (() -> Void)? { get set }
}

open class MvvmViewController<Model>: UIViewController, MvvmViewControllerProtocol
where Model: ViewControllerModel {

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
