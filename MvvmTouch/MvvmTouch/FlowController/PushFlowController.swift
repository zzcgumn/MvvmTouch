//
//  PushFlowController.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 28/01/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import UIKit

public class PushFlowController<Presented> : FlowController
where Presented: UIViewController&MvvmViewControllerProtocol {
    typealias Controller = Presented

    static public var sequeIdentifier: String {
        let viewModelName = String(describing: ViewModel.self)
        return "push\(viewModelName)"
    }

    public init() { }

    public func present(
        presentingViewController: UIViewController,
        makeViewModel: () -> Presented.ViewModel,
        makeViewController: (Presented.ViewModel) -> Presented
        ) {

        let viewModel = makeViewModel()
        let presentedViewController = makeViewController(viewModel)

        let seque = UIStoryboardSegue(identifier: PushFlowController.sequeIdentifier,
                                      source: presentingViewController,
                                      destination: presentedViewController) {
                                        if let nav = presentingViewController.navigationController {
                                            nav.pushViewController(presentedViewController, animated: true)
                                        }
        }

        seque.perform()    }
}
