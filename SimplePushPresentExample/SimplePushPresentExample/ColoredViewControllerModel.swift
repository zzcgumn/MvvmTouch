//
//  ColoredViewControllerModel.swift
//  SimplePushPresentExample
//
//  Created by Martin Nygren on 24/01/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import Foundation
import MvvmTouch

class ColoredViewControllerModel : ViewControllerModel {
    
    var backgroundColor = UIColor.white
    
    private let _dismiss: () -> Void
    func dismissAction() {
        _dismiss()
    }
    
    required init(dismiss: @escaping () -> Void) {
        _dismiss = dismiss
    }
    
}
