//
//  MvvmViewController+Flows.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 05/07/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import UIKit

extension MvvmViewController {

    public func modalFlow<Destination: MvvmPresentableViewController>(
        makeViewModel: @escaping (_ sourceModel: Model) -> Destination.ViewModel = { _ in Destination.ViewModel() },
        makeViewController: @escaping () -> Destination = { return Destination.make() },
        onCompleted: @escaping (_ destinationModel: Destination.ViewModel, _ sourceModel: Model) -> Void = {_, _ in }
        ) -> Flow<MvvmViewController, Destination> {

        let destinationController = makeViewController()

        let followFlow: (_ sourceModel: Model) -> Void = { sourceModel in
            let flowController = PresentFlowController<Destination, Destination.ViewModel>()
            let makeDestinationViewModel = { makeViewModel(self.viewModel!) }

            let makeDestination: () -> Destination = {
                var vc = makeViewController()
                if vc.dismissAction == nil {
                    vc.dismissAction = {
                        let dismissCompleted = { onCompleted(vc.viewModel!, self.viewModel!) }
                        self.dismiss(animated: true, completion: dismissCompleted)
                    }
                }

                return vc
            }

            flowController.present(presentingViewController: self,
                         makeViewModel: makeDestinationViewModel,
                         makeViewController: makeDestination)
        }

        let result: Flow<MvvmViewController, Destination> =
        Flow(source: self,
             destination: destinationController,
             onFollow: { sourceModel in followFlow(sourceModel) },
             onCompleted: onCompleted)

        return result
    }
}
