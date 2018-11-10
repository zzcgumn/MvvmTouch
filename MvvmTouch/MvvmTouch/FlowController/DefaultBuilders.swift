//
//  DefaultBuilders.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 09/11/2018.
//  Copyright © 2018 Martin Nygren. All rights reserved.
//

import Foundation

public func defaultMakeViewController<T>(viewModel: T.ViewModel) -> T
    where T: UIViewController&MvvmViewControllerProtocol {
    var viewController = T()
    viewController.viewModel = viewModel

    return viewController
}
