//
//  PresentFlowController.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 23/01/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

public class PresentFlowController<Presented, ViewModel>
where ViewModel: ViewControllerModel, Presented: MvvmViewController<ViewModel> {
    
    static var sequeIdentifier: String {
        let viewModelName = String(describing: ViewModel.self)
        return "present\(viewModelName)"
    }
    
    public init() {
        
    }
    
    public func present(presentingViewController: UIViewController,
                        configureViewModel: (_ viewModel: ViewModel) -> Void = {_ in },
                        makeViewController: () -> Presented = {Presented()}) {
        
        let presentedViewController = makeViewController()
        
        let vm = ViewModel(dismiss: {
            presentingViewController.dismiss(animated: true, completion: .none)
        })
        
        presentedViewController.viewModel = vm
        configureViewModel(vm)
        
        let seque = UIStoryboardSegue(identifier: PresentFlowController.sequeIdentifier,
                                      source: presentingViewController,
                                      destination: presentedViewController) {
                                        presentingViewController.present(presentedViewController, animated: true, completion: .none)
        }
        
        seque.perform()
    }
}

