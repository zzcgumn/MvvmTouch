//
//  MvvmViewController+Flows.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 05/07/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import UIKit

extension MvvmViewController {
    
    public func modalFlow<Destination, DestinationModel: ViewModel>(
        makeViewModel: (_ sourceModel: Model?) -> DestinationModel,
        makeViewController: () -> Destination = { Destination() }) -> Flow
        where Destination: MvvmViewController<DestinationModel> {
            let destionationViewModel = makeViewModel(viewModel)
            let destinationController = makeViewController()
            let flow = PushFlowController<Destination, DestinationModel>()

            return Flow(source: self,
                        destination: destinationController,
                        follow: {
                            flow.present(presentingViewController: self,
                                         makeViewModel: { destionationViewModel },
                                         makeViewController: { destinationController})
            })

    }

}
