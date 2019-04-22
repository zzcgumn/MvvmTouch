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
                            makeViewController: @escaping MakeViewController,
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

public extension Flow where
Destination.ViewModel: DefaultInitialisable {
    public static func push(source: Source,
                            makeViewController: @escaping MakeViewController,
                            onCompleted: @escaping Completing = { _, _ in }) -> Flow<Source, Destination> {

        return push(source: source,
                    makeViewModel: { _ in Destination.ViewModel() },
                    makeViewController: makeViewController,
                    onCompleted: onCompleted)
    }
}

public extension Flow where Destination: DefaultInitialisable {
    public static func push(source: Source,
                            makeViewModel: @escaping MakeViewModel,
                            onCompleted: @escaping Completing = { _, _ in }) -> Flow<Source, Destination> {

        return push(source: source,
                    makeViewModel: makeViewModel,
                    makeViewController: defaultMakeViewController,
                    onCompleted: onCompleted)
    }
}

public extension Flow where
Destination: DefaultInitialisable,
Destination.ViewModel: DefaultInitialisable  {
    public static func push(source: Source,
                            onCompleted: @escaping Completing = { _, _ in }) -> Flow<Source, Destination> {

        return push(source: source,
                    makeViewModel: { _ in Destination.ViewModel() },
                    makeViewController: defaultMakeViewController,
                    onCompleted: onCompleted)
    }
}