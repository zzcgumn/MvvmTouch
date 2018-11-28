//
//  Flow.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 05/07/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import UIKit

public class Flow<Source: UIViewController&MvvmViewControllerProtocol,
Destination: UIViewController&MvvmViewControllerProtocol> {
    public let source: Source
    public let onFollow: (_ sourceModel: Source.ViewModel?) -> Void
    public let sequeIdentifier: String

    public typealias Following = (_ : Source.ViewModel?) -> Void
    public typealias Completing = (_ destinationModel: Destination.ViewModel?, _ sourceModel: Source.ViewModel?) -> Void
    public typealias MakeViewModel = (_ sourceModel: Source.ViewModel?) -> Destination.ViewModel
    public typealias MakeViewController = (Destination.ViewModel) -> Destination

    public init(source: Source,
                onFollow: @escaping Following,
                sequeIdentifier: String) {
        self.source = source
        self.onFollow = onFollow
        self.sequeIdentifier = sequeIdentifier
    }

    public func follow() {
        onFollow(source.viewModel)
    }
}

internal extension Flow {
    internal static func makeFollowing<FC: FlowController>(flowController: FC,
                                                           source: Source,
                                                           makeViewModel: @escaping MakeViewModel,
                                                           makeViewController: @escaping MakeViewController,
                                                           onCompleted: @escaping Completing)
        -> Flow<Source, Destination> where FC.Controller == Destination {
            let followFlow: (_ sourceModel: Source.ViewModel?) -> Void = { sourceModel in
                let makeDestinationViewModel = { makeViewModel(sourceModel) }

                let makeDestination: (Destination.ViewModel) -> Destination = { viewModel in
                    var viewController = makeViewController(viewModel)

                    if let currentAction = viewController.dismissAction {
                        viewController.dismissAction = {
                            onCompleted(viewController.viewModel, source.viewModel)
                            currentAction()
                        }
                    } else {
                        viewController.dismissAction = {
                            onCompleted(viewController.viewModel, source.viewModel)
                            source.dismiss(animated: true, completion: nil)
                        }
                    }

                    return viewController
                }

                flowController.present(presentingViewController: source,
                                       makeViewModel: makeDestinationViewModel,
                                       makeViewController: makeDestination)
            }

            return Flow<Source, Destination>(source: source,
                                             onFollow: followFlow,
                                             sequeIdentifier: "")
    }
}

