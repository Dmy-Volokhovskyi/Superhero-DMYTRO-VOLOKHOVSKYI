//
//  BodyParameterStorage.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 20/03/2022.
//

import UIKit
import CoreData

class BodyParameterStorage {
    
    static let sharedInstance = BodyParameterStorage()
    
    let profile = ProfileManager.sharedInstance.userProfile
    let context = ProfileManager.sharedInstance.mainContext
    var compareArray : [BodyParameterModel] = []
    var toggledArray : [BodyParameterModel] = []
    
    var bodyParameterStorage = [BodyParameter]()
    let measurementUnitCM = "cm"
    let measurementUnitKG = "kg"
    let parameters = ["Height","Weight","Neck","Shoulders","Left biceps","RightBiceps","Left hip","Right hip","Right forearm","Left forearm","Chest","Left lower leg","Right lover let","Right ankle","Left ancle"]
    
    func getBodyParameters() -> NSOrderedSet{
        for parameter in parameters {
            
            let newBodyParameter  = BodyParameter(context: context)
            
            newBodyParameter.isChosen = false
            newBodyParameter.measureValue = 0
            newBodyParameter.measuredIn = measurementUnitCM
            newBodyParameter.parameterName = parameter
            newBodyParameter.isToggled = false
            newBodyParameter.parentProfile = ProfileManager.sharedInstance.userProfile
            if parameter == "Weight"{
                newBodyParameter.measuredIn = measurementUnitKG
            }else {
                newBodyParameter.measuredIn = measurementUnitCM
            }
            newBodyParameter.parentProfile = ProfileManager.sharedInstance.userProfile
            bodyParameterStorage.append(newBodyParameter)
        }
        return  NSOrderedSet(array :bodyParameterStorage)
    }
}
