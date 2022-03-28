//
//  ProfileManager.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 20/02/2022.
//

import Foundation
import UIKit
import CoreData

class ProfileManager {
    
    static let sharedInstance = ProfileManager()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var operableArray : [BodyParameterModel] = []
    
    var userProfile : Profile?
    
    var parameterArray : [BodyParameter] = []
    
    //    MARK: -
    func createDefaultProfile (with sex : String) {
        userProfile = Profile(context: context)
        userProfile?.sex = sex
        userProfile?.name = nil
        userProfile?.parameters = BodyParameterStorage.sharedInstance.getBodyParameters()
        saveData()
    }
    
    func saveData() {
        do {
            try context.save()
        }catch{
            print("Error saving Context \(error)")
        }
    }
    
    func loadProfileInformation() {
        let request : NSFetchRequest<Profile> = Profile.fetchRequest()
        request.returnsObjectsAsFaults = false
        do{
            let userProfileArray =  try context.fetch(request)
            if userProfileArray != [] {
                print(userProfileArray.count)
                userProfile = userProfileArray[0]
            }
        }catch {
            print ( "Error fetching data \(error)" )
        }
    }
    
    func loadBodyParameters (){
        let fetchRequest: NSFetchRequest<BodyParameter>
        
        fetchRequest = BodyParameter.fetchRequest()
        
        let context = context
        do{
            parameterArray =  try context.fetch(fetchRequest)
            operableArray = BodyParameterStorage.sharedInstance.formOprableArray()
            print(operableArray.count)
        }catch {
            print (error)
        }
    }
    
    func saveParameterChanges(newParameters : [BodyParameterModel], and name : String) {
        userProfile?.setValue(name, forKey: "name")
        
        if userProfile?.parameters?.count == newParameters.count {
            for parameter in 0...newParameters.count-1 {
                parameterArray[parameter].isChosen = newParameters[parameter].isChosen
                parameterArray[parameter].isToggled = newParameters[parameter].isToggled
                parameterArray[parameter].measureValue = newParameters[parameter].measureValue
            }
        }
        saveData()
    }
}
