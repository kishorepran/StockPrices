//
//  SPBaseViewModel.swift
//  StocksPrice
//
//  Created by Pran Kishore on 29.09.20.
//  Copyright © 2020 Sample Solutions. All rights reserved.
//

import Foundation

protocol ViewModelDelegate: class {
    func viewModelDidUpdate(sender: SPBaseViewModel)
    func viewModelUpdateFailed(error: SPError)
}

class SPBaseViewModel: NSObject {
    weak var delegate: ViewModelDelegate?
}
