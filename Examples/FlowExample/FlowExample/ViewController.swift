//
//  ViewController.swift
//  FlowExample
//
//  Created by Martin Nygren on 15/07/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import UIKit
import MvvmTouch

class RootViewControllerModel: ViewControllerModel {
    public required init() { }
}

class ViewController: MvvmViewController<RootViewControllerModel> {

    var chooseColorFlow: Flow<ViewController, ColoredViewController>?

    @objc func action(sender: UIButton!) {
        chooseColorFlow?.follow()
    }

    @IBOutlet var selectColorButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        chooseColorFlow = Flow<ViewController, ColoredViewController>.modalFlow(
            source: self,
            makeViewModel: {_ in return ColoredViewControllerModel(backgroundColor: .green) }
        )

        selectColorButton.addTarget(self, action: #selector(action(sender:)), for: .touchUpInside)
    }

}

