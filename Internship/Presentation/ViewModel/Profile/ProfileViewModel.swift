//
//  ProfileViewModel.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 22/02/2022.
//

import Foundation
import UIKit
struct ProfileViewModel {
    
    var profile  = ProfileManager.sharedInstance.userProfile
    let barButtonTitle = "Profile"
    let nameLabel = "Name"
    let placeholderText = "Enter Your Name"
    let instructionText = "Select an option to display on the main screen"
    let addOptionsButtonText = "Add Options"
    let girlImage = UIImage(named: "girlBackgroundCut")
    let manlImage = UIImage(named: "manBackgroundCut")
    let whiteBackgroundColor = UIColor(named: "whiteBackground")
    
    var cameraImage : UIImage {
        let cameraImage = UIImage(named: "Camera")
        cameraImage?.withTintColor(.white)
        return cameraImage!
    }
    
    func getbackgroundImage () -> UIImage{
        if profile?.sex == "SUPERGIRL"{
            return girlImage ?? UIImage()
        }else {
            return manlImage ?? UIImage()
        }
    }
}
