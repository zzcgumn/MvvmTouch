//
//  Flow.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 05/07/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import UIKit

public class Flow<Source: UIViewController&MvvmViewControllerProtocol,
Destination: UIViewController&MvvmViewControllerProtocol> {
    public let source: Source
    public let onFollow: (_ sourceModel: Source.ViewModel?) -> Void
    public let sequeIdentifier: String

    public typealias Following = (_ : Source.ViewModel?) -> Void
    public typealias Completing = (_ destinationModel: Destination.ViewModel?, _ sourceModel: Source.ViewModel?) -> Void
    public typealias MakeViewModel = (_ sourceModel: Source.ViewModel?) -> Destination.ViewModel
    public typealias MakeViewController = (Destination.ViewModel) -> Destination

    public init(source: Source,
                onFollow: @escaping Following,
                sequeIdentifier: String) {
        self.source = source
        self.onFollow = onFollow
        self.sequeIdentifier = sequeIdentifier
    }

    public func follow() {
        onFollow(source.viewModel)
    }
}
