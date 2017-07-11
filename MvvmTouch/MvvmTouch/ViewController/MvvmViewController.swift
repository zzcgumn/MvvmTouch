//
//  MvvmViewController.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 23/01/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import UIKit

public protocol MvvmViewControllerProtocol {
    associatedtype ViewModel: ViewControllerModel
    var viewModel: ViewModel? { get set }
    var dismissAction: (() -> Void)? { get set }
    static func make() -> Self
}

public protocol MvvmPresentableViewController {
    var showCloseButton: Bool { get set}
}

open class MvvmViewController<Model: ViewControllerModel>: UIViewController, MvvmViewControllerProtocol {
    public typealias ViewModel = Model

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

    public var showCloseButton: Bool = false {
        didSet {
            if showCloseButton {
                doShowCloseButton()
            } else {
                doHideCloseButton()
            }
        }
    }

    open static func make() -> Self {
        return self.init()
    }
}

extension MvvmViewController: MvvmPresentableViewController { }
