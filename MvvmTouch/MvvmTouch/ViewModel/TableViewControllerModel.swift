//
//  TableViewControllerModel.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 12/02/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import Foundation

/** View models for a MvvmTableViewController needs to implement this protocol */
public protocol TableViewControllerModel: ViewControllerModel {
    var dataSource: MvvmTableViewDataSource { get }
}
