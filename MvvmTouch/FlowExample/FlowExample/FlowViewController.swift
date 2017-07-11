//
//  ViewController.swift
//  FlowExample
//
//  Created by Martin Nygren on 05/07/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import UIKit
import MvvmTouch

class RootViewControllerModel: ViewControllerModel {
    public required init() { }
}

class FlowViewController: MvvmViewController<RootViewControllerModel> {

    var chooseColorFlow: Flow<FlowViewController, ColoredTableViewController>?

    @objc func action(sender: UIButton!) {

    }

    @IBOutlet var pinkButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        chooseColorFlow = Flow<FlowViewController, ColoredTableViewController>.modalFlow(source: self)

        pinkButton.addTarget(self, action: #selector(action(sender:)), for: .touchUpInside)
    }

}
