//
//  PresentFlowController.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 23/01/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

class PresentFlowController<Presented, ViewModel>
where ViewModel: ViewControllerModel, Presented: MvvmViewController<ViewModel> {
    
    static var sequeIdentifier: String {
        let viewModelName = String(describing: ViewModel.self)
        return "present\(viewModelName)"
    }
    
    func present(presentingViewController: UIViewController) {
        
        let presented = Presented()
        presented.viewModel = ViewModel(dismiss: {
            presentingViewController.dismiss(animated: true, completion: .none)
        })
        
        let seque = UIStoryboardSegue(identifier: PresentFlowController.sequeIdentifier,
                                      source: presentingViewController,
                                      destination: presented) {
                                        presentingViewController.present(presented, animated: true, completion: .none)
        }
        
        seque.perform()
    }
}

