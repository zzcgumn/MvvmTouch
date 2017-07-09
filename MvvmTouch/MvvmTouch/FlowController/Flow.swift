//
//  Flow.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 05/07/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import UIKit

public class Flow<
    SourceModel, Source: MvvmViewController<SourceModel>,
    DestinationModel, Destination: MvvmViewController<DestinationModel>> {
    public let source: Source
    public let destination: Destination
    public let onFollow: (_ sourceModel: SourceModel) -> Void
    public let onCompleted: (_ destinationModel: DestinationModel, _ sourceModel: SourceModel) -> Void

    public init(source: Source,
                destination: Destination,
                onFollow: @escaping (_ : SourceModel) -> Void = { _ in  },
                onCompleted: @escaping (_ destinationModel: DestinationModel, _ sourceModel: SourceModel) -> Void
        = {_,_ in   }) {
        self.source = source
        self.destination = destination
        self.onFollow = onFollow
        self.onCompleted = onCompleted
    }
}
