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
     let context = ProfileManager.sharedInstance.context

     var bodyParameterStorage = [BodyParameter]()
    let measurementUnitCM = "cm"
    let measurementUnitKG = "kg"
    let parameters = ["Height","Weight","Neck","Shoulders","Left biceps","RightBiceps","Left hip","Right hip","Right forearm","Left forearm","Chest","Left lower leg","Right lover let","Right ankle","Left ancle"]

     func getBodyParameters() -> NSOrderedSet{
            for parameter in parameters {
                
                let newBodyParameter  = BodyParameter(context: context)
                
                newBodyParameter.isChosen = false
                newBodyParameter.measureValue = " "
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
     
    func formOprableArray () -> [BodyParameterModel] {
        
        var operableArray = [BodyParameterModel]()
        for parameter in ProfileManager.sharedInstance.parameterArray {
            let newParameter = BodyParameterModel(parameterName: parameter.parameterName, measuredIn: parameter.measuredIn, measureValue: parameter.measureValue, isChosen: parameter.isChosen, isToggled: parameter.isToggled)
            operableArray.append(newParameter)
        }
        ProfileManager.sharedInstance.operableArray = operableArray
        return operableArray
    }
     
}
