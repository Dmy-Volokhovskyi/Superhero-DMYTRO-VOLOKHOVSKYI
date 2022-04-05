
//
//  StartViewModel.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 21/02/2022.
//

import UIKit
struct StartViewModel {

    
    let mainTitle = "superhero"
    let manButtonTitle =  "superman"
    let girlButtonTitle =  "supergirl"
    let chooseHeroTitle = "выберите героя"
    let girlBackgroundImage = UIImage(named: "girlBack")
    let manBackgroundImage = UIImage(named: "manBack")
    
    func chooseSex(with name: String) {
        ProfileManager.sharedInstance.createDefaultProfile(with: name)
    }
}
