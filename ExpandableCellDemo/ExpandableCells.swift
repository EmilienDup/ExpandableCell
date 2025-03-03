//
//  ExpandableCells.swift
//  ExpandableCell
//
//  Created by Seungyoun Yi on 2017. 8. 7..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import UIKit
import ExpandableCell


class NormalCell: UITableViewCell {
    static let ID = "NormalCell"
}

class ExpandableCell2: ExpandableCell {
    static let ID = "ExpandableCell"
}
class ExpandableSelectableCell2: ExpandableCell {
    static let ID = "ExpandableSelectableCell2"

    override func awakeFromNib() {
        self.setIsSelectable(true)
    }
}

class ExpandableInitiallyExpanded: ExpandableCell {
    static let ID = "InitiallyExpandedExpandableCell"
    
    override func awakeFromNib() {
        self.setIsSelectable(true)
        self.setIsInitiallyExpanded(true)
    }
}

class ExpandedCell: UITableViewCell {
    static let ID = "ExpandedCell"
    
    @IBOutlet var titleLabel: UILabel!
}
