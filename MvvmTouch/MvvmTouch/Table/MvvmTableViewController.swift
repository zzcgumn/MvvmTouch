//
//  MvvmTableViewController.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 06/02/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import UIKit

protocol MvvmCellTableViewSectionDataSource {
    var numberOfItems: Int { get }
    var cellIdentfier: String { get }
    func makeCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}

protocol MvvmCellTableViewDataSource {
    var sections: [MvvmCellTableViewSectionDataSource] { get }
}

open class MvvmCellTableViewDataSourceSection<CellModel>: MvvmCellTableViewSectionDataSource
where CellModel: TableCellModel {
    var models: [CellModel] = []

    func makeCell(tableView: UITableView, model: CellModel) -> MvvmTableViewCell<CellModel> {

    }
}

open class MvvmCellTableViewController<CellModel>
where CellModel: TableCellModel {

    var dataSections: [CellModel] = []
}
