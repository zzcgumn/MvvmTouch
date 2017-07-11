//
//  MvvmViewController+Flows.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 05/07/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import UIKit

extension MvvmViewController {

    public func modalFlow<DestinationModel, Destination>(
        makeViewModel: @escaping (_ sourceModel: Model) -> DestinationModel = { _ in DestinationModel() },
        makeViewController: @escaping () -> Destination = { return Destination.make() },
        onCompleted: @escaping (_ destinationModel: DestinationModel, _ sourceModel: Model) -> Void = {_, _ in }
        ) -> Flow<Model, MvvmViewController, DestinationModel, Destination>
    where
        Destination: MvvmPresentableViewController,
        Destination.Model == DestinationModel,
        Destination.Controller == Destination {
        let destinationController = makeViewController()

        let followFlow: (_ sourceModel: Model) -> Void = { sourceModel in
            let flowController = PresentFlowController<Destination, DestinationModel>()
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

        let result: Flow<Model, MvvmViewController, DestinationModel, Destination> =
        Flow(source: self,
             destination:destinationController,
             onFollow: { sourceModel in followFlow(sourceModel) },
             onCompleted: onCompleted)

        return result
    }
}
