//
//  ViewController.swift
//  SimplePushPresentExample
//
//  Created by Martin Nygren on 23/01/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import UIKit
import MvvmTouch

class ViewController: UIViewController {

    let presentFlowController = PresentFlowController<ColoredViewController, ColoredViewControllerModel>()
    let pushFlowController = PushFlowController<ColoredViewController, ColoredViewControllerModel>()

    @IBAction func presentColoredViewController(_ sender: UIButton) {
        presentFlowController.present(presentingViewController: self, makeViewModel: {
            return ColoredViewControllerModel(backgroundColor: sender.currentTitleColor)
        })
    }

    @IBAction func pushColoredViewController(_ sender: UIButton) {
        pushFlowController.present(presentingViewController: self, makeViewModel: {
            return ColoredViewControllerModel(backgroundColor: sender.currentTitleColor)
        })
    }
}
