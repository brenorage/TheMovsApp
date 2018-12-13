//
//  FilterOptionCell.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 13/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class FilterOptionCell: UITableViewCell {

    @IBOutlet private weak var optionLabel: UILabel!
    
    func setOption(with text: String) {
        optionLabel.text = text
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            self.accessoryType = .checkmark
        } else {
            self.accessoryType = .none
        }
    }
}
