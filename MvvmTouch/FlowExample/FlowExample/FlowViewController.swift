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

class FlowViewController: MvvmViewController<RootViewControllerModel> {

    @IBOutlet var pinkButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
