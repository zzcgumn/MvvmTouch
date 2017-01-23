//
//  ViewControllerModel.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 23/01/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import Foundation

public protocol ViewControllerModel {
    
    func dismissAction() -> Void
    
    init(dismiss: @escaping () -> Void)
}
