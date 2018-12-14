//
//  FilterTypeCell.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 13/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class FilterTypeCell: UITableViewCell {

    @IBOutlet private weak var filterTypeLabel: UILabel!
    @IBOutlet private weak var selectedOptionLabel: UILabel!
    
    func setFilterTypeLabel(with label: String) {
        filterTypeLabel.text = label
    }
    
    func setSelectedOption(with selectedOption: String) {
        selectedOptionLabel.text = selectedOption
    }
}
