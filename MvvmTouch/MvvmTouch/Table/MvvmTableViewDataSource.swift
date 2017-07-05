//
//  MvvmTableViewDataSource.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 12/02/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import UIKit

public protocol MvvmTableViewSectionDataSource {
    var numberOfItems: Int { get }
    var cellIdentfier: String { get }
    func makeCell(tableView: UITableView, row: Int) -> UITableViewCell
    var sectionHeaderTitle: String? { get }
    var sectionFooterTitle: String? { get }
    func canEdit(elementAt: Int) -> Bool
    func canMove(elementAt: Int) -> Bool
}

/** Minimalistic convenience implementation of MvvmTableViewSectionDataSource. */
open class MvvmTableViewSection<CellModel, CellType>: MvvmTableViewSectionDataSource where
      CellModel: TableCellModel,
      CellType: UITableViewCell,
      CellType: MvvmTableViewCellProtocol,
      CellType.Model == CellModel {

    public var models: [CellModel]

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

    open var sectionHeaderTitle: String? { return nil }

    open var sectionFooterTitle: String? { return nil }

    open func canEdit(elementAt: Int) -> Bool {
        return false
    }

    open func canMove(elementAt: Int) -> Bool {
        return false
    }
}

public protocol MvvmTableViewDataSource: UITableViewDataSource {
    var sections: [MvvmTableViewSectionDataSource] { get }
}

/** Minimalistic convenience implementation of MvvmTableViewDataSource. 
 
 Note that these methods cannot be declared in a protocol extension of MvvmTableViewDataSource
 since protocol extension methods cannot be called from Objective-C
 */
open class MvvmUITableViewDataSource: NSObject, MvvmTableViewDataSource {
    private func sectionAt(_ index: Int) -> MvvmTableViewSectionDataSource? {
        if index < sections.count {
            return sections[index]
        } else {
            return nil
        }
    }

    public var sections: [MvvmTableViewSectionDataSource]

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].numberOfItems
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sections[indexPath.section].makeCell(tableView: tableView, row: indexPath.row)
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    public init(sections: [MvvmTableViewSectionDataSource]) {
        self.sections = sections
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let section = sectionAt(section) {
            return section.sectionHeaderTitle
        } else {
            return nil
        }
    }

    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if let section = sectionAt(section) {
            return section.sectionFooterTitle
        } else {
            return nil
        }
    }

    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if let section = sectionAt(indexPath.section) {
            return section.canEdit(elementAt: indexPath.row)
        } else {
            return false
        }
    }

    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if let section = sectionAt(indexPath.section) {
            return section.canMove(elementAt: indexPath.row)
        } else {
            return false
        }
    }

    public func tableView(_ tableView: UITableView,
                          commit editingStyle: UITableViewCellEditingStyle,
                          forRowAt indexPath: IndexPath) {
        fatalError("MvvmUITableViewDataSource must be subclassed to support editing rows.")
    }

    public func tableView(_ tableView: UITableView,
                          moveRowAt sourceIndexPath: IndexPath,
                          to destinationIndexPath: IndexPath) {

        fatalError("MvvmUITableViewDataSource must be subclassed to support moving rows.")
    }
}
