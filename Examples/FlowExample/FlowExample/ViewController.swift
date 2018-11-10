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

    func colorFlow<T>(source: T) -> Flow<T, ColoredViewController>
        where T: UIViewController&MvvmViewControllerProtocol {
            return .modalFlow(
                source: source,
                makeViewModel: { _ in ColoredViewControllerModel(backgroundColor: .green) }
            )
    }

    func imageFlow<T>(source: T) -> Flow<T, ColoredViewController> where T: UIViewController&MvvmViewControllerProtocol {
        return .pushFlow(
            source: source,
            makeViewModel: { _ in ColoredViewControllerModel(backgroundColor: .brown) }
        )
    }
}

class ViewController: MvvmViewController<RootViewControllerModel> {

    var chooseColorFlow: Flow<ViewController, ColoredViewController>?
    var chooseImageFlow: Flow<ViewController, ColoredViewController>?

    @objc func colorAction(sender: UIButton!) {
        viewModel?.colorFlow(source: self).follow()
    }

    @objc func imageAction(sender: UIButton!) {
        viewModel?.imageFlow(source: self).follow()
    }

    @IBOutlet var selectColorButton: UIButton!
    @IBOutlet var selectImageButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = RootViewControllerModel()

        selectColorButton.addTarget(self, action: #selector(colorAction(sender:)), for: .touchUpInside)
        selectImageButton.addTarget(self, action: #selector(imageAction(sender:)), for: .touchUpInside)
    }

}

