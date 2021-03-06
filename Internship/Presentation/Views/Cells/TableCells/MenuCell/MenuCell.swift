//
//  MenuCell.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 22/02/2022.
//

import UIKit

class MenuCell: UITableViewCell {
    
    @IBOutlet weak var menuItemLabel: UILabel!
    @IBOutlet weak var bottomLine: UIView!
    static let cellID = "MenuCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setUpCell (with text : String) {
        menuItemLabel.text = text
        menuItemLabel.textColor = .white
        bottomLine.backgroundColor = .white
        menuItemLabel.font = UIFont(name:"HelveticaNeue", size: 18.0)
        backgroundColor = UIColor.clear
    }
}
