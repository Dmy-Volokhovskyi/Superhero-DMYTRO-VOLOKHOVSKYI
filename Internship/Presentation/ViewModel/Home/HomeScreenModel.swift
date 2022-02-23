//
//  HomeScreenViewModel.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 21/02/2022.
//

import Foundation
import UIKit

struct HomeScreenModel {
    
    let gender = ProfileManager.sharedInstance.userProfile?.sex ?? ""
    let menuArray = ["Профиль","Прогресс","Программы","Калькулятор","Мышцы"]
    let reuseIdentifier = "Cell"
    let cellNibName = "MenuCell"
    let girlImage = UIImage(named: "girlBackgroundCut")
    let manlImage = UIImage(named: "manBackgroundCut")
    let manTitle = "Superman"
    let girlTitle = "Supergirl"
    
    // perform transition to new screen
    func categorySelected (with index : Int, coordinator : MainCoordinator)  {
        
       let menuCategory = menuArray[index]
        switch menuCategory {
        case "Профиль" :
            coordinator.profile()
        case "Прогресс":
            coordinator.progress()
        case "Программы":
            coordinator.programs()
        case "Калькулятор":
            coordinator.calculator()
        case "Мышцы":
            coordinator.muscle()
        default:
            coordinator.profile()
        }
    }

}
