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
    let girlImage = "girlBackgroundCut"
    let manlImage =  "manBackgroundCut"
    let whiteBackgroundColor = UIColor(named: "whiteBackground")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    

    
    
    var cameraImage : UIImage {
        let cameraImage = UIImage(named: "Camera")
        cameraImage?.withTintColor(.white)
        return cameraImage!
    }
    
    func getbackgroundImage () -> String{
        if profile?.sex == "SUPERGIRL"{
            return girlImage
        }else {
            return manlImage
        }
    }
    func saveOptionsArray(parameters : [BodyParameterModel], and name : String) {
        
        ProfileManager.sharedInstance.saveParameterChanges(newParameters: parameters, and: name)
    }

func checkIfDifferent(newArray : [BodyParameterModel]) -> Bool{
    let difference = newArray.difference(from: BodyParameterStorage.sharedInstance.formOprableArray())
    if difference.insertions == [] || difference.removals == [] {
        return false
    }else {
        return true
    }
}
    func updateAtRowDeletion ( with operableArray : [BodyParameterModel], and parameterName : String) -> [BodyParameterModel] {
        var mutableAray = [BodyParameterModel] ()
        for  parametr in operableArray {
            if  parametr.parameterName != parameterName{
                mutableAray.append(parametr)
            }else {
                let changed = BodyParameterModel(parameterName: parametr.parameterName, measuredIn: parametr.measuredIn, measureValue: parametr.measureValue, isChosen: false, isToggled: false)
                mutableAray.append(changed)
            }
        }
        return mutableAray
    }
    func getData()-> [BodyParameterModel] {
        BodyParameterStorage.sharedInstance.formOprableArray()
    }
}
