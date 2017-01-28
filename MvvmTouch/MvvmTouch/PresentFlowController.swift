//
//  PresentFlowController.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 23/01/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import UIKit

public class PresentFlowController<Presented, ViewModel> : FlowController
where ViewModel: ViewControllerModel, Presented: MvvmViewController<ViewModel> {

    static var sequeIdentifier: String {
        let viewModelName = String(describing: ViewModel.self)
        return "present\(viewModelName)"
    }

    public init() {

    }

    public func present(presentingViewController: UIViewController,
                        makeViewModel: () -> ViewModel,
                        makeViewController: () -> Presented = {Presented()}) {

        let presentedViewController = makeViewController()
        presentedViewController.dismissAction = {
            presentingViewController.dismiss(animated: true, completion: .none)
        }

        let vm = makeViewModel()
        presentedViewController.viewModel = vm

        presentedViewController.showCloseButton = true

        let seque = UIStoryboardSegue(identifier: PresentFlowController.sequeIdentifier,
                                      source: presentingViewController,
                                      destination: presentedViewController) {
                                        presentingViewController.present(presentedViewController,
                                                                         animated: true,
                                                                         completion: .none)
        }

        seque.perform()
    }
}
