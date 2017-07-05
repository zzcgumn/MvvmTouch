//
//  ViewController.swift
//  FlowExample
//
//  Created by Martin Nygren on 05/07/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import UIKit
import MvvmTouch

class RootViewControllerModel: ViewControllerModel { }

class ViewController: MvvmViewController<RootViewControllerModel> {

    @IBAction func presentColoredViewController(_ sender: UIButton) {
        presentFlowController.present(presentingViewController: self, makeViewModel: {
            return ColoredViewControllerModel(backgroundColor: sender.currentTitleColor)
        })
    }

}
