//
//  Flow.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 05/07/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import UIKit

public class Flow {
    public let source: UIViewController
    public let destination: UIViewController
    public let follow: () -> Void

    public init(source: UIViewController,
                destination: UIViewController,
                follow: @escaping () -> Void) {
        self.source = source
        self.destination = destination
        self.follow = follow
    }
}
