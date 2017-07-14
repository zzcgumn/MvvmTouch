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

    public init(source: Source,
                destination: Destination,
                onFollow: @escaping (_ : Source.ViewModel?) -> Void = { _ in  },
                onCompleted: @escaping (_ destinationModel: Destination.ViewModel, _ sourceModel: Source.ViewModel) -> Void
        = {_, _ in   }) {
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
                                 makeViewModel: @escaping (_ sourceModel: Source.ViewModel?) -> Destination.ViewModel = { _ in Destination.ViewModel()},
                                 makeViewController: @escaping () -> Destination = { return Destination.make() },
                                 onCompleted: @escaping (_ destinationModel: Destination.ViewModel?, _ sourceModel: Source.ViewModel?) -> Void = {_, _ in }) -> Flow<Source, Destination> {

        let followFlow: (_ sourceModel: Source.ViewModel?) -> Void = { sourceModel in
            let flowController = PresentFlowController<Destination, Destination.ViewModel>()
            let makeDestinationViewModel = { makeViewModel(sourceModel) }

            let makeDestination: () -> Destination = {
                var vc = makeViewController()
                if vc.dismissAction == nil {
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
