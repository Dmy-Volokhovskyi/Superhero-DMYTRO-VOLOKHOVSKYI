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
    @IBOutlet  weak var whiteBackgroundImg: UIImageView!
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
        nameLabel.text = profileViewModel.userName
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
        getWhiteImage()
        self.backgroundView = backgroundView
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        checkForState()
    }
    
    @IBAction func pickImage(_ sender: UIButton) {
        //        self.delegate?.presentImagePicker()
        self.delegate?.presentImagePicker()
        
        
        
    }
    func getWhiteImage() {
        whiteBackgroundImg.image = ProfileManager.sharedInstance.getUnwreppedImage()
        if ProfileManager.sharedInstance.userProfile?.profileImage != nil {
            cameraDefaultImage.image = UIImage()
            whiteBackgroundImg.contentMode = .scaleToFill
            whiteBackgroundImg.layer.borderWidth = 1
            whiteBackgroundImg.layer.borderColor = UIColor(red: 0.906, green: 0.769, blue: 0.341, alpha: 1).cgColor
        }
    }
    
    func setImage (with imageView : UIImageView?) {
        if let imageView = imageView {
            whiteBackgroundImg.image = imageView.image
            whiteBackgroundImg.contentMode = .scaleToFill
            cameraDefaultImage.isHidden = true
            whiteBackgroundImg.layer.borderWidth = 1
            whiteBackgroundImg.layer.borderColor = UIColor(red: 0.906, green: 0.769, blue: 0.341, alpha: 1).cgColor
        }
        if imageView?.image == nil{
            cameraDefaultImage.isHidden = false
            whiteBackgroundImg.layer.borderWidth = 0
        }
    }
    
    func checkForState (){
        if let text = enterNameTextView.text {
            if text == profileViewModel.profile?.name || text == "" {
                lineColorView.backgroundColor = UIColor.getCustomOrangeColor()
                self.delegate?.gotData(self, text, false)
            }else {
                lineColorView.backgroundColor = .white
                self.delegate?.gotData(self, text, true)
            }
        }
    }
}

