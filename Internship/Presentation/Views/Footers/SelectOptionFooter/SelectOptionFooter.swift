//
//  SelectOptionFooter.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 19/03/2022.
//

import UIKit

protocol SelectOptionFooterDelegate {
    func saveUpdatedArray ()
}

class SelectOptionFooter: UITableViewHeaderFooterView {
    
 static let footerID = "SelectOptionFooter"
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var selectButton: UIButton!
    var delegate : SelectOptionFooterDelegate?
    
    func setFooter() {
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.tintColor = .white
        selectButton.setTitle("Select", for: .normal)
        selectButton.tintColor = UIColor(named: "yellowUIColor")
    }
    @IBAction func selectButtonPressed(_ sender: UIButton) {
        print("cancel")
    }
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        delegate?.saveUpdatedArray()
    }
}
