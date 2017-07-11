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
    public let destination: Destination
    public let onFollow: (_ sourceModel: Source.ViewModel) -> Void
    public let onCompleted: (_ destinationModel: Destination.ViewModel, _ sourceModel: Source.ViewModel) -> Void

    public init(source: Source,
                destination: Destination,
                onFollow: @escaping (_ : Source.ViewModel) -> Void = { _ in  },
                onCompleted: @escaping (_ destinationModel: Destination.ViewModel, _ sourceModel: Source.ViewModel) -> Void
        = {_, _ in   }) {
        self.source = source
        self.destination = destination
        self.onFollow = onFollow
        self.onCompleted = onCompleted
    }
}

extension Flow where Destination: MvvmPresentableViewController {
    public static func modalFlow(source: Source) -> Flow<Source, Destination> {
        return Flow<Source, Destination>(source: source,
                    destination: Destination.make(),
                    onFollow: { _ in  },
                    onCompleted: {_, _ in   })
    }
}
