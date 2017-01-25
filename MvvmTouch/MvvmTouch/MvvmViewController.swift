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
    
    @objc private func closeButtonTapped(_ sender: UIButton) {
        viewModel?.dismissAction()
    }
    
    private var closeButton: UIButton? = .none
    private func doShowCloseButton() {
        if closeButton == .none {
            closeButton = UIButton(type: .system)
        }
        
        if let button = closeButton {
            button.isHidden = false
            button.isEnabled = true
            button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
            
            button.setTitle("Close", for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setContentHuggingPriority(1.0, for: .vertical)
            button.setContentHuggingPriority(1.0, for: .horizontal)
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
        }
    }
    
    
    private func doHideCloseButton() {
        guard let button = closeButton else {
            return
        }
        
        button.isHidden = true
        button.removeFromSuperview()
        closeButton = .none
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

