//
//  ProfileViewController.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 22/02/2022.
//

import UIKit

class ProfileViewController: UIViewController,Storyboarded {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var whiteBackgroundImg: UIImageView!
    @IBOutlet weak var cameraDefaultImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var enterNameTextView: UITextField!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var addOptionsButton: UIButton!
    
    weak var coordinator : MainCoordinator?
    let profileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = profileViewModel.barButtonTitle
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isOpaque = true
        setUpInterface()
        view.layoutIfNeeded()
    }
    func setUpInterface (){
        backgroundImage.image = profileViewModel.getbackgroundImage()
//        whiteBackgroundImg.backgroundColor = profileViewModel.whiteBackgroundColor
//        cameraDefaultImage.image = profileViewModel.cameraImage
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
