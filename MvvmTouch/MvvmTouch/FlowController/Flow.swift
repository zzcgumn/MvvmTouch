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
    public let destination: Destination
    public let onFollow: (_ sourceModel: Source.ViewModel?) -> Void
    public let onCompleted: (_ destinationModel: Destination.ViewModel, _ sourceModel: Source.ViewModel) -> Void

    public typealias Following = (_ : Source.ViewModel?) -> Void
    public typealias Completing = (_ destinationModel: Destination.ViewModel?, _ sourceModel: Source.ViewModel?) -> Void
    public typealias MakeViewModel = (_ sourceModel: Source.ViewModel?) -> Destination.ViewModel
    public typealias MakeViewController = () -> Destination

    public init(source: Source,
                destination: Destination,
                onFollow: @escaping Following,
                onCompleted: @escaping Completing) {
        self.source = source
        self.destination = destination
        self.onFollow = onFollow
        self.onCompleted = onCompleted
    }

    public func follow() {
        onFollow(source.viewModel)
    }
}

extension Flow where Destination: MvvmPresentableViewController {
    public static func modalFlow(source: Source,
                                 makeViewModel: @escaping MakeViewModel = { _ in Destination.ViewModel()},
                                 makeViewController: @escaping MakeViewController = { return Destination.make() },
                                 onCompleted: @escaping Completing = {_, _ in }) -> Flow<Source, Destination> {

        let followFlow: (_ sourceModel: Source.ViewModel?) -> Void = { sourceModel in
            let flowController = PresentFlowController<Destination>()
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
                                         destination: Destination.make(),
                                         onFollow: followFlow,
                                         onCompleted: onCompleted)
    }
}

extension Flow {
    public static func pushFlow(source: Source,
                                 makeViewModel: @escaping MakeViewModel = { _ in Destination.ViewModel()},
                                 makeViewController: @escaping MakeViewController = { return Destination.make() },
                                 onCompleted: @escaping Completing = {_, _ in }) -> Flow<Source, Destination> {
        
        let followFlow: (_ sourceModel: Source.ViewModel?) -> Void = { sourceModel in
            let flowController = PushFlowController<Destination>()
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
                                         destination: Destination.make(),
                                         onFollow: followFlow,
                                         onCompleted: onCompleted)
    }
}
