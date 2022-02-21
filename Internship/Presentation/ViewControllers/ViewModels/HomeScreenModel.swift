//
//  HomeScreenViewModel.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 21/02/2022.
//

import Foundation
import UIKit

struct HomeScreenModel {
    
    var profile = ProfileManager.sharedInstance.userProfile
    let girlBackgroundImage = UIImage(named: "girlBackgroundCut")
    let manBackgroundImage = UIImage(named: "manBackgroundCut")
    
    let manTitle =  NSMutableAttributedString(string: "Superman", attributes: [NSAttributedString.Key.font : UIFont(name: "SairaRoman-Regular", size: 24)!, NSAttributedString.Key.foregroundColor : UIColor.white])
    let girlTitle =  NSMutableAttributedString(string: "Supergirl", attributes: [NSAttributedString.Key.font : UIFont(name: "SairaRoman-Regular", size: 24)!, NSAttributedString.Key.foregroundColor : UIColor.white])
}
