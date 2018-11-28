//
//  Flow+Push.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 28/11/2018.
//  Copyright © 2018 Martin Nygren. All rights reserved.
//

import UIKit

extension Flow {
    public static func push(source: Source,
                            makeViewModel: @escaping MakeViewModel,
                            makeViewController: @escaping MakeViewController = defaultMakeViewController,
                            onCompleted: @escaping Completing = { _, _ in }) -> Flow<Source, Destination> {
        let sequeIdentifier = "\(Source.self):push:\(Destination.self)"

        let followFlow: (_ sourceModel: Source.ViewModel?) -> Void = { sourceModel in
            let viewModel = makeViewModel(sourceModel)
            var presentedViewController = makeViewController(viewModel)

            if let currentAction = presentedViewController.dismissAction {
                presentedViewController.dismissAction = {
                    onCompleted(presentedViewController.viewModel, source.viewModel)
                    currentAction()
                }
            } else {
                presentedViewController.dismissAction = {
                    onCompleted(presentedViewController.viewModel, source.viewModel)
                }
            }

            let seque = UIStoryboardSegue(identifier: sequeIdentifier,
                                          source: source,
                                          destination: presentedViewController) {
                                            if let nav = source.navigationController {
                                                nav.pushViewController(presentedViewController, animated: true)
                                            }
            }

            seque.perform()
        }

        return Flow(source: source,
                    onFollow: followFlow,
                    sequeIdentifier: sequeIdentifier)
    }
}
