//
//  SettingsTableViewCell.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 14/03/2022.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    @IBOutlet weak var atributeName: UILabel!
    @IBOutlet weak var statusSwitch: UISwitch!
    @IBOutlet weak var measurementUnit: UILabel!
    @IBOutlet weak var quantity: UILabel!
    static let cellID = "SettingsTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCell() {
        atributeName.text = "Banana"
        measurementUnit.text = "SM"
        quantity.text = "179"
        atributeName.textColor = .white
        measurementUnit.textColor = .white
        quantity.textColor = .white
        
        backgroundColor = .clear
    }
}
