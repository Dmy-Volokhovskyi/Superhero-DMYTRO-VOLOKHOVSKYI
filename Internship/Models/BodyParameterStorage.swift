//
//  BodyParameterStorage.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 20/03/2022.
//

import UIKit
import CoreData

final class BodyParameterStorage {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var bodyParameterStorage  = ProfileManager.sharedInstance.parameterArray
    let measurementUnitCM = "cm"
    let measurementUnitKG = "kg"
    let parameters = ["Height","Weight","Neck","Shoulders","Left biceps","RightBiceps","Left hip","Right hip","Right forearm","Left forearm","Chest","Left lower leg","Right lover let","Right ankle","Left ancle"]
    
    func getBodyParameters() -> [BodyParameter] {
        if bodyParameterStorage.count == 0 {
            for parameter in parameters {
                let newBodyParameter  = BodyParameter(context: context)
                
                newBodyParameter.isChosen = false
                newBodyParameter.measureValue = " "
                newBodyParameter.measuredIn = measurementUnitCM
                newBodyParameter.parameterName = parameter
                newBodyParameter.parentProfile?.name = ProfileManager.sharedInstance.userProfile?.name
                if parameter == "Weight"{
                    newBodyParameter.measuredIn = measurementUnitKG
                }else {
                    newBodyParameter.measuredIn = measurementUnitCM
                }
                bodyParameterStorage.append(newBodyParameter)
            }
            print (bodyParameterStorage.count)
            return bodyParameterStorage
        }else {
            return bodyParameterStorage
        }
    }
}
