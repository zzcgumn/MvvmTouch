//
//  FlowController.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 28/01/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import Foundation
import UIKit

protocol FlowController {
    associatedtype ViewModel
    associatedtype ViewController

    static var sequeIdentifier: String { get }

    func present(presentingViewController: UIViewController,
                 makeViewModel: () -> ViewModel,
                 makeViewController: () -> ViewController)
}
