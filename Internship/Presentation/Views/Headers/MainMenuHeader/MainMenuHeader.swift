//
//  MainMenuHeader.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 14/03/2022.
//


import UIKit


class MainMenuHeader: UITableViewHeaderFooterView, UITextFieldDelegate {
    
    static let reuseID = "MainMenuHeader"
    @IBOutlet private weak var lineColorView: UIView!
    @IBOutlet private weak var whiteBackgroundImg: UIImageView!
    @IBOutlet private weak var cameraDefaultImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var enterNameTextView: UITextField!
    private var profileViewModel : ProfileViewModel!
    
    var delegate : MainMenuHeaderDelegate?
    
    func setupHeader(_ model : ProfileViewModel) {
        profileViewModel = model
        enterNameTextView.delegate = self
        whiteBackgroundImg.backgroundColor = profileViewModel.whiteBackgroundColor
        whiteBackgroundImg.layer.cornerRadius = 13
        cameraDefaultImage.image = profileViewModel.cameraImage
        nameLabel.text = profileViewModel.nameLabel
        nameLabel.textColor = .white
        nameLabel.font = UIFont(name: "HelveticaNeue", size: 18.0)
        enterNameTextView.borderStyle = .none
        enterNameTextView.text = profileViewModel.profile?.name
        enterNameTextView.attributedPlaceholder = NSAttributedString(
            string: profileViewModel.placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "descriptionText")!,NSAttributedString.Key.font : UIFont(name: "HelveticaNeue", size: 18.0)!])
        enterNameTextView.textColor = UIColor.white
        enterNameTextView.font = UIFont(name: "HelveticaNeue", size: 18.0)
        let backgroundView = UIView(frame: self.bounds)
        backgroundView.backgroundColor = UIColor.clear
        self.backgroundView = backgroundView
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        checkForState()
    }
    
    func checkForState (){
        if let text = enterNameTextView.text {
            if text == profileViewModel.profile?.name || text == "" {
                print("Match")
                lineColorView.backgroundColor = .orange
                self.delegate?.gotData(self, text, false)
            }else {
                lineColorView.backgroundColor = .white
                self.delegate?.gotData(self, text, true)
                print("DontMatch")
                
            }
        }
    }
}

