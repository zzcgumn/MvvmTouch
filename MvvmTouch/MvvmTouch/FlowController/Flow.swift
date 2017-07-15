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

    public typealias Following = (_ : Source.ViewModel?) -> Void
    public typealias Completing = (_ destinationModel: Destination.ViewModel?, _ sourceModel: Source.ViewModel?) -> Void
    public typealias MakeViewModel = (_ sourceModel: Source.ViewModel?) -> Destination.ViewModel
    public typealias MakeViewController = () -> Destination

    public init(source: Source,
                onFollow: @escaping Following) {
        self.source = source
        self.onFollow = onFollow
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

                let makeDestination: () -> Destination = {
                    var vc = makeViewController()
                    if let currentAction = vc.dismissAction {
                        vc.dismissAction = {
                            onCompleted(vc.viewModel, source.viewModel)
                            currentAction()
                        }
                    } else {
                        vc.dismissAction = {
                            onCompleted(vc.viewModel, source.viewModel)
                            source.dismiss(animated: true, completion: nil)
                        }
                    }

                    return vc
                }

                flowController.present(presentingViewController: source,
                                       makeViewModel: makeDestinationViewModel,
                                       makeViewController: makeDestination)
            }

            return Flow<Source, Destination>(source: source,
                                             onFollow: followFlow)
    }
}

extension Flow where Destination: MvvmPresentableViewController {
    public static func modalFlow(source: Source,
                                 makeViewModel: @escaping MakeViewModel = { _ in Destination.ViewModel()},
                                 makeViewController: @escaping MakeViewController = { return Destination.make() },
                                 onCompleted: @escaping Completing = {_, _ in }) -> Flow<Source, Destination> {

        let flowController = PresentFlowController<Destination>()

        return makeFollowing(flowController: flowController,
                             source: source,
                             makeViewModel: makeViewModel,
                             makeViewController: makeViewController,
                             onCompleted: onCompleted)
    }
}

extension Flow {
    public static func pushFlow(source: Source,
                                makeViewModel: @escaping MakeViewModel = { _ in Destination.ViewModel()},
                                makeViewController: @escaping MakeViewController = { return Destination.make() },
                                onCompleted: @escaping Completing = {_, _ in }) -> Flow<Source, Destination> {

        let flowController = PushFlowController<Destination>()

        return makeFollowing(flowController: flowController,
                             source: source,
                             makeViewModel: makeViewModel,
                             makeViewController: makeViewController,
                             onCompleted: onCompleted)
    }
}
