//
//  MvvmTableViewCell.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 25/01/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import UIKit

open class MvvmTableViewCell<Model> : UITableViewCell where Model: TableCellModel {

    open var model: Model?
}
