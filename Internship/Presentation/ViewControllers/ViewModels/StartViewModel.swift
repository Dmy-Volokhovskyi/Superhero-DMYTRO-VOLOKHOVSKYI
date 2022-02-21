//
//  StartViewModel.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 21/02/2022.
//

import Foundation
import UIKit
struct StartViewModel {
    // Tried to add atributes via code But couldnt find a way to use uppercased(), it works only with
    // regular strings, so Meanwhile I shall use Caps And i change it if required/
    let mainTitle =  NSMutableAttributedString(string: "SUPERHERO", attributes: [NSAttributedString.Key.font : UIFont(name: "Futura-Bold", size: 32)!, NSAttributedString.Key.foregroundColor : UIColor(named: "yellowUIColor") ?? UIColor.yellow])
    let manButtonTitle =  NSMutableAttributedString(string: "SUPERMAN", attributes: [NSAttributedString.Key.font : UIFont(name: "SairaRoman-Regular", size: 18)!, NSAttributedString.Key.foregroundColor : UIColor.black])
    let girlButtonTitle =  NSMutableAttributedString(string: "SUPERGIRL", attributes: [NSAttributedString.Key.font : UIFont(name: "SairaRoman-Regular", size: 18)!, NSAttributedString.Key.foregroundColor : UIColor.black])
    let chooseHeroTitle = NSMutableAttributedString(string:"выберите героя", attributes: [NSAttributedString.Key.font : UIFont(name: "SairaRoman-Regular", size: 16)!, NSAttributedString.Key.foregroundColor : UIColor.white])
    
    
    let girlBackgroundImage = UIImage(named: "girlBack")
    let manBackgroundImage = UIImage(named: "manBack")
    

    
    func chooseSex(with name: String) {
        ProfileManager.sharedInstance.createDefaultProfile(with: name)
    }
}
