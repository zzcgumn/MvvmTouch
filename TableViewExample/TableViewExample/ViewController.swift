//
//  ViewController.swift
//  TableViewExample
//
//  Created by Martin Nygren on 05/02/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import UIKit
import MvvmTouch

struct ColoredCellModel: TableCellModel {
    let backgroundColor: UIColor
}

class ColoredCellType: MvvmTableViewCell<ColoredCellModel> {

    override var model: ColoredCellModel? {
        didSet {
            self.backgroundView?.backgroundColor = model?.backgroundColor
            self.backgroundColor = model?.backgroundColor
        }
    }
}

class ViewController: MvvmCellModelTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let models = [ColoredCellModel(backgroundColor: .gray),
                      ColoredCellModel(backgroundColor: .green),
                      ColoredCellModel(backgroundColor: .blue)]

        dataSource.sections = [MvvmTableViewSection<ColoredCellModel, ColoredCellType>(models: models),
                               MvvmTableViewSection<ColoredCellModel, ColoredCellType>(models: models),
                               MvvmTableViewSection<ColoredCellModel, ColoredCellType>(models: models)]
        tableView.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
