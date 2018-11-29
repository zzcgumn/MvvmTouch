//
//  ShowFlowController.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 05/02/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import UIKit

public class ShowFlowController<Presented> : FlowController
where Presented: UIViewController&MvvmViewControllerProtocol {
    typealias Controller = Presented

    static public var sequeIdentifier: String {
        let viewModelName = String(describing: ViewModel.self)
        return "show\(viewModelName)"
    }

    public init() { }

    public func present(
        presentingViewController: UIViewController,
        makeViewModel: () -> Presented.ViewModel,
        makeViewController: (Presented.ViewModel) -> Presented
        ) {

        let viewModel = makeViewModel()
        let presentedViewController = makeViewController(viewModel)

        let seque = UIStoryboardSegue(identifier: ShowFlowController.sequeIdentifier,
                                      source: presentingViewController,
                                      destination: presentedViewController) { [weak self] in
                                        if let strongSelf = self {
                                            presentingViewController.show(presentedViewController, sender: strongSelf)
                                        }
        }

        seque.perform()
    }
}
