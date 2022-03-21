//
//  MainMenuFooter.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 14/03/2022.
//

import UIKit
class MainMenuFooter: UITableViewHeaderFooterView {
    
    @IBOutlet private weak var instructionLabel: UILabel!
    static let reuseID = "MainMenuFooter"
    
    func setUpFooter (with labelText : String){
        let backgroundView = UIView(frame: self.bounds)
        backgroundView.backgroundColor = UIColor.clear
        self.backgroundView = backgroundView
        instructionLabel.text = labelText
        instructionLabel.textColor = UIColor(named: "descriptionText")
        instructionLabel.font = UIFont(name: "SairaRoman-Regular", size: 16.0)
        
    }
}
