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
    var chooseImageFlow: Flow<ViewController, ColoredViewController>?

    @objc func colorAction(sender: UIButton!) {
        chooseColorFlow?.follow()
    }

    @objc func imageAction(sender: UIButton!) {
        chooseImageFlow?.follow()
    }

    @IBOutlet var selectColorButton: UIButton!
    @IBOutlet var selectImageButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        chooseColorFlow = Flow<ViewController, ColoredViewController>.modalFlow(
            source: self,
            makeViewModel: {_ in return ColoredViewControllerModel(backgroundColor: .green) }
        )

        chooseImageFlow = Flow<ViewController, ColoredViewController>.pushFlow(
            source: self,
            makeViewModel: {_ in return ColoredViewControllerModel(backgroundColor: .brown) }
        )

        selectColorButton.addTarget(self, action: #selector(colorAction(sender:)), for: .touchUpInside)
        selectImageButton.addTarget(self, action: #selector(imageAction(sender:)), for: .touchUpInside)

    }

}

