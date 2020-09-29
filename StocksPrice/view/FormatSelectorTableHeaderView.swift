//
//  FormatSelectorTableHeaderView.swift
//  StocksPrice
//
//  Created by Pran Kishore on 29.09.20.
//  Copyright © 2020 Sample Solutions. All rights reserved.
//

import UIKit

enum ChangeFormat: String, CaseIterable {
    case percent
    case value
}

protocol FormatTableHeaderViewDelegate: class {
    func didChange(to fomat: ChangeFormat)
}

class FormatTableHeaderView: UITableViewHeaderFooterView {

    static let reuseIdentifer = "FormatTableHeaderView"
    weak var delegate: FormatTableHeaderViewDelegate?
    private let segmentControl = UISegmentedControl(items: [ChangeFormat.percent.rawValue, ChangeFormat.value.rawValue])
    override public init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        segmentControl.addTarget(self, action: #selector(segmentControl(_:)), for: .valueChanged)
        segmentControl.selectedSegmentIndex = 0
        contentView.backgroundColor = .white
        //Layout changes
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(segmentControl)
        let margins = contentView.layoutMarginsGuide
        segmentControl.topAnchor.constraint(equalTo: margins.topAnchor, constant: 8).isActive = true
        segmentControl.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -8).isActive = true
        segmentControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -32).isActive = true
        segmentControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 32).isActive = true
    }
    
    @objc func segmentControl(_ segmentedControl: UISegmentedControl) {
       switch (segmentedControl.selectedSegmentIndex) {
          case 0:
            delegate?.didChange(to: .percent)
          case 1:
            delegate?.didChange(to: .value)
          default:
          break
       }
        print("Did select segment")
    }
}
