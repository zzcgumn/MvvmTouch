//
//  MvvmTableViewCell.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 25/01/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import UIKit

public protocol MvvmTableViewCellProtocol {
    associatedtype Model
    var model: Model? { get set }
}

open class MvvmTableViewCell<Model>: UITableViewCell, MvvmTableViewCellProtocol where Model: TableCellModel {

    open var model: Model?

    open override func prepareForReuse() {
        super.prepareForReuse()

        model = nil
    }
}
