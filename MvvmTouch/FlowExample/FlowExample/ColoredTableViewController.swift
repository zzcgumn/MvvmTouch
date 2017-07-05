//
//  ColoredTableViewController.swift
//  FlowExample
//
//  Created by Martin Nygren on 05/07/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

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

class ColoredCellSection: MvvmTableViewSection<ColoredCellModel, ColoredCellType> {
    private let _header: String?

    override var sectionHeaderTitle: String? { return _header }

    init(header: String, models: [ColoredCellModel]) {
        self._header = header

        super.init(models: models)
    }
}

class ViewController: MvvmCellModelTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let models = [ColoredCellModel(backgroundColor: .gray),
                      ColoredCellModel(backgroundColor: .green),
                      ColoredCellModel(backgroundColor: .blue)]

        dataSource.sections = [ColoredCellSection(header: "First Section", models: models),
                               ColoredCellSection(header: "Second Section", models: models),
                               ColoredCellSection(header: "Third Section", models: models)]
        tableView.reloadData()
    }
}
