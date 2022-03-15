//
//  MainMenuFooter.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 14/03/2022.
//

import UIKit
class MainMenuFooter: UITableViewHeaderFooterView {
    @IBOutlet weak var instructionLabel: UILabel!

    func setUpFooter (with labelText : String){
                instructionLabel.text = labelText
                instructionLabel.textColor = UIColor(named: "descriptionText")
                instructionLabel.font = UIFont(name: "SairaRoman-Regular", size: 16.0)
        
    }
}
