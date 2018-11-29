//
//  ColoredViewController.swift
//  SimplePushPresentExample
//
//  Created by Martin Nygren on 24/01/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import UIKit
import MvvmTouch

class ColoredViewController: MvvmViewController<ColoredViewControllerModel>, DefaultInitialisable {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = viewModel?.backgroundColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
