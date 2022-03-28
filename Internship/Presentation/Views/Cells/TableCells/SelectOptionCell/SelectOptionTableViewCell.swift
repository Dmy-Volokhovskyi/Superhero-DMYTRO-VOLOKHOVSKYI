//
//  SelectOptionTableViewCell.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 17/03/2022.
//

import UIKit

class SelectOptionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var optionNameLabel: UILabel!
    @IBOutlet weak var checkmarkImage: UIImageView!
    static let cellID = "SelectOptionTableViewCell"


    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUp(parameter : BodyParameterModel?) {
        if let parameter = parameter {
            self.backgroundColor = .clear
            optionNameLabel.text = parameter.parameterName
            optionNameLabel.textColor = .white
            let checkmark = UIImage(named: "Check")
            let empty = UIImage(named: "Box")
            
            checkmarkImage.image = parameter.isChosen == true ? checkmark : empty
        }
    }
}
