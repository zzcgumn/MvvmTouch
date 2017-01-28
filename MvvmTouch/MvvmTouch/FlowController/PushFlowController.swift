//
//  PushFlowController.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 28/01/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import Foundation

public class PushFlowController<Presented, ViewModel> : FlowController
where ViewModel: ViewControllerModel, Presented: MvvmViewController<ViewModel> {

    static public var sequeIdentifier: String {
        let viewModelName = String(describing: ViewModel.self)
        return "push\(viewModelName)"
    }

    public init() {

    }

    public func present(presentingViewController: UIViewController,
                        makeViewModel: () -> ViewModel,
                        makeViewController: () -> Presented = {Presented()}) {

        let presentedViewController = makeViewController()

        let vm = makeViewModel()
        presentedViewController.viewModel = vm

        presentedViewController.showCloseButton = true

        let seque = UIStoryboardSegue(identifier: PushFlowController.sequeIdentifier,
                                      source: presentingViewController,
                                      destination: presentedViewController) {
                                        if let nav = presentingViewController.navigationController {
                                            nav.pushViewController(presentedViewController, animated: true)
                                        }
        }

        seque.perform()    }
}
