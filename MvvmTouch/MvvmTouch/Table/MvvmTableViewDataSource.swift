//
//  MvvmTableViewDataSource.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 12/02/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import UIKit

public protocol MvvmCellTableViewSectionDataSource {
    var numberOfItems: Int { get }
    var cellIdentfier: String { get }
    func makeCell(tableView: UITableView, row: Int) -> UITableViewCell
}

open class MvvmCellTableViewDataSourceSection<CellModel, CellType>: MvvmCellTableViewSectionDataSource
where CellModel: TableCellModel, CellType: UITableViewCell, CellType: MvvmTableViewCellProtocol, CellType.Model == CellModel {

    public var models: [CellModel] = []

    public var numberOfItems: Int { return models.count }

    open var cellIdentfier: String {
        let cellModelName = String(describing: CellModel.self)
        return "cell\(cellModelName)"
    }

    private func makeMvvmCell(tableView: UITableView, model: CellModel) -> CellType? {
        var uiTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentfier)
        if uiTableViewCell == nil {
            tableView.register(CellType.self, forCellReuseIdentifier: cellIdentfier)
            uiTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentfier)
        }

        var cell: CellType? = uiTableViewCell as? CellType
        cell?.model = model

        return cell
    }

    open func makeCell(tableView: UITableView, row: Int) -> UITableViewCell {
        let cell: CellType? = makeMvvmCell(tableView: tableView, model: models[row])

        return cell!
    }

    public init(models: [CellModel]) {
        self.models = models
    }
}

public protocol MvvmCellTableViewDataSource {
    var sections: [MvvmCellTableViewSectionDataSource] { get }
}

open class MvvmTableViewDataSource: NSObject, MvvmCellTableViewDataSource, UITableViewDataSource {
    public var sections: [MvvmCellTableViewSectionDataSource]

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].numberOfItems
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sections[indexPath.section].makeCell(tableView: tableView, row: indexPath.row)
    }


    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    public init(sections: [MvvmCellTableViewSectionDataSource]) {
        self.sections = sections
    }
}
