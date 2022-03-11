//
//  ProfileViewController.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 22/02/2022.
//

import UIKit

class ProfileViewController: UIViewController,Storyboarded {
    
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var whiteBackgroundImg: UIImageView!
    @IBOutlet weak var cameraDefaultImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var enterNameTextView: UITextField!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var addOptionsButton: UIButton!
    
    @IBOutlet weak var hideTableViewConstraint: NSLayoutConstraint!
    weak var coordinator : MainCoordinator?
    let profileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isOpaque = true
        setUpInterface()
        view.layoutIfNeeded()
    }
    func setUpInterface (){
        backgroundImage.image = profileViewModel.getbackgroundImage()
        whiteBackgroundImg.backgroundColor = profileViewModel.whiteBackgroundColor
        whiteBackgroundImg.layer.cornerRadius = 13
        cameraDefaultImage.image = profileViewModel.cameraImage
        nameLabel.text = profileViewModel.nameLabel
        nameLabel.textColor = .white
        nameLabel.font = UIFont(name: "HelveticaNeue", size: 18.0)!
        enterNameTextView.attributedPlaceholder = NSAttributedString(
            string: profileViewModel.placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "descriptionText")!,NSAttributedString.Key.font : UIFont(name: "HelveticaNeue", size: 18.0)!])
        instructionLabel.text = profileViewModel.instructionText
        instructionLabel.textColor = UIColor(named: "descriptionText")
        instructionLabel.font = UIFont(name: "SairaRoman-Regular", size: 16.0)
        addOptionsButton.setTitle(profileViewModel.addOptionsButtonText, for: .normal)
        addOptionsButton.tintColor = .black
        addOptionsButton.backgroundColor = UIColor(named: "yellowUIColor")
        addOptionsButton.layer.cornerRadius = 25
        addOptionsButton.titleLabel?.font = UIFont(name: "SairaRoman-Regular", size: 16)
        let savedButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(savedButtonPressed))
        self.navigationItem.rightBarButtonItem  = savedButton
        self.title = profileViewModel.barButtonTitle
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @objc  func savedButtonPressed (){
        
    }
    @IBAction func addOptionsPressed(_ sender: UIButton) {
        self.hideTableViewConstraint.constant = 11
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        for fontFamilyName in UIFont.familyNames{
            for fontName in UIFont.fontNames(forFamilyName: fontFamilyName){
                print("Family: \(fontFamilyName)     Font: \(fontName)")
            }
        }
    }
}
