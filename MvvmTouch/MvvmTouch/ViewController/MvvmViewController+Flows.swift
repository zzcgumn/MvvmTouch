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
        makeViewController: @escaping () -> Destination = { Destination() },
        onCompleted: @escaping (_ destinationModel: DestinationModel, _ sourceModel: Model) -> Void = {_, _ in }
        ) -> Flow<Model, MvvmViewController, DestinationModel, Destination> {
        let destinationController = makeViewController()

        let followFlow: (_ sourceModel: Model) -> Void = { sourceModel in
            let flowController = PresentFlowController<Destination, DestinationModel>()
            let makeDestinationViewModel: () -> DestinationModel

            if let viewModel = self.viewModel {
                makeDestinationViewModel = { makeViewModel(viewModel) }
            } else {
                makeDestinationViewModel = { DestinationModel() }
            }

            flowController.present(presentingViewController: self,
                         makeViewModel: makeDestinationViewModel,
                         makeViewController: makeViewController)
        }

        let result: Flow<Model, MvvmViewController, DestinationModel, Destination> =
        Flow(source: self,
             destination:destinationController,
             onFollow: { sourceModel in followFlow(sourceModel) },
             onCompleted: onCompleted)

        return result
    }
}
