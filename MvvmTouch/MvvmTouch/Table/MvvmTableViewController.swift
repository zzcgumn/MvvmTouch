//
//  MvvmTableViewController.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 12/02/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import UIKit

open class MvvmTableViewController<Model>: MvvmViewController<Model>
where Model: TableViewControllerModel {
    public let tableView = UITableView()
    public override var viewModel: Model? {
        didSet {
            tableView.dataSource = viewModel?.dataSource
        }
    }

    open override func awakeFromNib() {
        super.awakeFromNib()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        view.addConstraints(constraintsForTableView())
    }

    open func constraintsForTableView() -> [NSLayoutConstraint] {
        return makeFillViewConstraints(subView: tableView)
    }
}
