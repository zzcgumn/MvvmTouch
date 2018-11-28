//
//  Flow+Modal.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 28/11/2018.
//  Copyright © 2018 Martin Nygren. All rights reserved.
//

import UIKit

extension Flow where Destination: MvvmPresentableViewController {
    public static func present(source: Source,
                               makeViewModel: @escaping MakeViewModel,
                               makeViewController: @escaping MakeViewController = defaultMakeViewController,
                               onCompleted: @escaping Completing = { _, _ in }) -> Flow<Source, Destination> {
        let sequeIdentifier = "\(Source.self):present:\(Destination.self)"

        let followFlow: (_ sourceModel: Source.ViewModel?) -> Void = { sourceModel in
            let viewModel = makeViewModel(sourceModel)
            var presentedViewController = makeViewController(viewModel)

            if let currentAction = presentedViewController.dismissAction {
                presentedViewController.dismissAction = {
                    onCompleted(presentedViewController.viewModel, source.viewModel)
                    currentAction()
                    source.dismiss(animated: true, completion: .none)
                }
            } else {
                presentedViewController.dismissAction = {
                    onCompleted(presentedViewController.viewModel, source.viewModel)
                    source.dismiss(animated: true, completion: .none)
                }
            }

            presentedViewController.showCloseButton = true

            let seque = UIStoryboardSegue(identifier: sequeIdentifier,
                                          source: source,
                                          destination: presentedViewController) {
                                            source.present(presentedViewController,
                                                           animated: true,
                                                           completion: .none)
            }

            seque.perform()
        }

        return Flow(source: source,
                    onFollow: followFlow,
                    sequeIdentifier: sequeIdentifier)
    }
}

public extension Flow where Destination: MvvmPresentableViewController, Destination.ViewModel: DefaultInitialisable {
    public static func present(source: Source,
                               makeViewController: @escaping MakeViewController = defaultMakeViewController,
                               onCompleted: @escaping Completing = { _, _ in }) -> Flow<Source, Destination> {

        return present(source: source,
                       makeViewModel: { _ in Destination.ViewModel() },
                       makeViewController: makeViewController,
                       onCompleted: onCompleted)
    }
}
