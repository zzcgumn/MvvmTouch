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
    
    @IBAction func presentColoredViewController(_ sender: UIButton) {
        presentFlowController.present(presentingViewController: self, makeViewModel: {
            return ColoredViewControllerModel(backgroundColor: sender.currentTitleColor)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

