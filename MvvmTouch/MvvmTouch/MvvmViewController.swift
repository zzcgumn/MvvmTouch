//
//  MvvmViewController.swift
//  MvvmTouch
//
//  Created by Martin Nygren on 23/01/2017.
//  Copyright © 2017 Martin Nygren. All rights reserved.
//

import UIKit

public class MvvmViewController<ViewModel> : UIViewController where ViewModel: ViewControllerModel {
    
    public var viewModel: ViewModel?
    
}

