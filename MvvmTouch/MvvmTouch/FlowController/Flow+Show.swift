//
//  Flow+Show.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 28/11/2018.
//  Copyright © 2018 Martin Nygren. All rights reserved.
//

import Foundation

extension Flow {
    public func show(source: Source,
                     makeViewModel: @escaping MakeViewModel,
                     makeViewController: @escaping MakeViewController = defaultMakeViewController,
                     onCompleted: @escaping Completing = { _, _ in } ) -> Flow<Source, Destination> {
        let sequeIdentifier = "\(Source.self):show:\(Destination.self)"

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
                                            source.show(presentedViewController, sender: source)
            }

            seque.perform()
        }

        return Flow(source: source,
                    onFollow: followFlow,
                    sequeIdentifier: sequeIdentifier)
    }
}

public extension Flow where Destination.ViewModel: DefaultInitialisable {
    public static func show(source: Source,
                            makeViewController: @escaping MakeViewController = defaultMakeViewController,
                            onCompleted: @escaping Completing = { _, _ in }) -> Flow<Source, Destination> {

        return push(source: source,
                    makeViewModel: { _ in Destination.ViewModel() },
                    makeViewController: makeViewController,
                    onCompleted: onCompleted)
    }
}
