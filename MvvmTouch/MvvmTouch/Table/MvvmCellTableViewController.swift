//
//  MvvmTableViewController.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 06/02/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import UIKit

/** Connects a UITableView with a MvvmTableViewDataSource */
open class MvvmCellModelTableViewController: UIViewController {
    public let tableView = UITableView()
    public let dataSource = MvvmUITableViewDataSource(sections: [])

    open override func awakeFromNib() {
        super.awakeFromNib()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = dataSource

        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        view.addConstraints(constraintsForTableView())
    }

    open func constraintsForTableView() -> [NSLayoutConstraint] {
        return makeFillViewConstraints(subView: tableView)
    }

}
