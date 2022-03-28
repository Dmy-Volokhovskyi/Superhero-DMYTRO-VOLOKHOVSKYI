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
    let name  = ProfileManager.sharedInstance.userProfile?.name ?? ""
    let menuArray = ["Профилі","Прогресс","Программы","Калькулятор","Мышцы"]
    let reuseIdentifier = "Cell"
    let cellNibName = "MenuCell"
    let girlImage = "girlBackgroundCut"
    let manlImage = "manBackgroundCut"
    let manTitle = "Superman"
    let girlTitle = "Supergirl"
    var modelArray : [BodyParameterModel] = []
    var toggledArray : [BodyParameterModel] = []

    
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
   mutating func formToggledArray () -> [BodyParameterModel]{
       modelArray = BodyParameterStorage.sharedInstance.formOprableArray()
       toggledArray = []
        for parameter in modelArray {
            if parameter.isToggled == true{
                self.toggledArray.append(parameter)
            }
        }
       print(" toggle \(toggledArray.count)  ")     
       return toggledArray
    }
}
