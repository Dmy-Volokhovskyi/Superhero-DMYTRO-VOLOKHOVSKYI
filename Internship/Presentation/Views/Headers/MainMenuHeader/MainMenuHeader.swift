//
//  MainMenuHeader.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 14/03/2022.
//

import Foundation
import UIKit
class MainMenuHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var lineVIew: UIView!
    @IBOutlet weak var whiteBackgroundImg: UIImageView!
    @IBOutlet weak var cameraDefaultImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var enterNameTextView: UITextField!
    var profileViewModel = ProfileViewModel()
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    func setupHeader() {
        
        whiteBackgroundImg.backgroundColor = profileViewModel.whiteBackgroundColor
        whiteBackgroundImg.layer.cornerRadius = 13
        cameraDefaultImage.image = profileViewModel.cameraImage
        nameLabel.text = profileViewModel.nameLabel
        nameLabel.textColor = .white
        nameLabel.font = UIFont(name: "HelveticaNeue", size: 18.0)!
        enterNameTextView.borderStyle = .none
        enterNameTextView.text = profileViewModel.profile?.name
        
        enterNameTextView.attributedPlaceholder = NSAttributedString(
            string: profileViewModel.placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "descriptionText")!,NSAttributedString.Key.font : UIFont(name: "HelveticaNeue", size: 18.0)!])
        enterNameTextView.textColor = UIColor.white
        enterNameTextView.font = UIFont(name: "HelveticaNeue", size: 18.0)
        NotificationCenter.default.post(name: UITextField.textDidChangeNotification, object: self.enterNameTextView)
    }
    
}

