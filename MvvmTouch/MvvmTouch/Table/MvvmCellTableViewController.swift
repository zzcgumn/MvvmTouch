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

    open override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource

        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        view.addConstraints(constraintsForTableView())
    }

    open func constraintsForTableView() -> [NSLayoutConstraint] {
        let top = view.topAnchor
        let bottom = view.bottomAnchor

        let margins = view.layoutMarginsGuide
        let allConstraints = [
            tableView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        ]

        allConstraints.forEach{ $0.isActive = true }

        return allConstraints
    }

}

