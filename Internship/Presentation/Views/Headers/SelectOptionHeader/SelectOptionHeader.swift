//
//  SelectOptionHeader.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 20/03/2022.
//

import UIKit

class SelectOptionHeader: UITableViewHeaderFooterView {

    
    @IBOutlet weak var titleLabel: UILabel!
    static let headerID = "SelectOptionHeader"
 
  func setUp() {
      titleLabel.text = "Select Option"
      titleLabel.textAlignment = .center
      titleLabel.textColor = UIColor(named: "yellowUIColor")
      titleLabel.font =  UIFont(name: "SairaRoman-Regular", size: 16)
      titleLabel.backgroundColor = .red
    }
  
}
