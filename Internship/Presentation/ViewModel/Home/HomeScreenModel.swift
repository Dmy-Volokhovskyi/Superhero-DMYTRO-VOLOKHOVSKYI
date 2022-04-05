//
//  HomeScreenViewModel.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 21/02/2022.
//

import Foundation
import UIKit

class HomeScreenModel {
    let profile = ProfileManager.sharedInstance.userProfile
    let gender = ProfileManager.sharedInstance.userProfile?.sex ?? ""
    let name  = ProfileManager.sharedInstance.userProfile?.name ?? ""
    let menuArray = ["Profile","Progress","Programs","Calculator","Muscle"]
    let reuseIdentifier = "Cell"
    let cellNibName = "MenuCell"
    let girlImage = UIImage(named: "girlBackgroundCut")
    let manlImage = UIImage(named: "manBackgroundCut")
    let manTitle = "Superman"
    let girlTitle = "Supergirl"
    let genderCheck = "SUPERGIRL"
    var parameters : [BodyParameter]?
    var modelArray : [BodyParameterModel] = []
    var toggledArray : [BodyParameterModel] = []
    
    
    
    
    init () {
        fetchParameters()
        toggledArray = formToggledArray()
    }
    
    func categorySelected (with index : Int, coordinator : MainCoordinator)  {
        
        let menuCategory = menuArray[index]
        switch menuCategory {
        case "Profile" :
            coordinator.profile()
        case "Progress":
            coordinator.progress()
        case "Programs":
            coordinator.programs()
        case "Calculator":
            coordinator.calculator()
        case "Muscle":
            coordinator.muscle()
        default:
            coordinator.profile()
        }
    }
    
    func getbackgroundImage () -> UIImage? {
        let profile = ProfileManager.sharedInstance.userProfile
        if profile?.sex == "SUPERGIRL"{
            return girlImage
        }else {
            return manlImage
        }
    }
    
    func setProfileImage () -> UIImage? {
        return ProfileManager.sharedInstance.getUnwreppedImage()
    }
    
    func formToggledArray () -> [BodyParameterModel]{
        toggledArray = []
        for parameter in modelArray {
            if parameter.isToggled == true{
                self.toggledArray.append(parameter)
            }
        }
        return toggledArray
    }
    private func fetchParameters() {
        guard let profile = profile else { return }
        
        
        parameters = Array(_immutableCocoaArray: profile.parameters!)
        
        if let parameters = parameters {
            modelArray = parameters.map({ parameter -> BodyParameterModel in
                createBodyParameterModel(with: parameter)
            })
        }
    }
    
    private func createBodyParameterModel(with parameter: BodyParameter) -> BodyParameterModel {
        return BodyParameterModel(model: parameter)
    }
}
