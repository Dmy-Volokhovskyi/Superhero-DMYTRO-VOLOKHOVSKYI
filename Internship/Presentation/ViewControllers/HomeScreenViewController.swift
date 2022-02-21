//
//  HomeScreenVC.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 20/02/2022.
//

import Foundation
import UIKit

class HomeScreenViewController : UIViewController,Storyboarded{
    
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    weak var coordinator : MainCoordinator?
    let homeScreenModel = HomeScreenModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        setInterface()
    }
    private func setInterface() {
        let gender = ProfileManager.sharedInstance.userProfile?.sex ?? ""
        
        if gender == "SUPERGIRL"{
            backgroundImage.image = homeScreenModel.girlBackgroundImage
            genderLabel.attributedText = homeScreenModel.girlTitle
        }else {
            backgroundImage.image = homeScreenModel.manBackgroundImage
            genderLabel.attributedText = homeScreenModel.manTitle
        }
        backgroundImage.contentMode = .scaleToFill
    }
}


