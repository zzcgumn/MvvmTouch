//
//  ShowFlowController.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 05/02/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import UIKit

public class ShowFlowController<Presented, ViewModel> : FlowController
where Presented: MvvmViewController<ViewModel> {

    static public var sequeIdentifier: String {
        let viewModelName = String(describing: ViewModel.self)
        return "show\(viewModelName)"
    }

    public init() {

    }

    public func present(presentingViewController: UIViewController,
                        makeViewModel: () -> ViewModel,
                        makeViewController: () -> Presented = {Presented()}) {

        let presentedViewController = makeViewController()

        let vm = makeViewModel()
        presentedViewController.viewModel = vm

        presentedViewController.showCloseButton = false

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
