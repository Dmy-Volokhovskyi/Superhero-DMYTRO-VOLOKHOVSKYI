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
    
    var userProfile : Profile?
    {
        didSet {
            loadBodyParameters()
            print(parameterArray.count)
        }
    }
    var chosenParametersArray = [BodyParameter]()
    
    var parameterArray : [BodyParameter] = [] {
        didSet {
            for parameter in parameterArray {
                if parameter.isChosen == true {
                    chosenParametersArray.append(parameter)
                }
            }
        }
    }
    
    
    func createDefaultProfile (with sex : String) {
        userProfile = Profile(context: context)
        userProfile?.sex = sex
        saveData()
    }
    func saveProfileWith (with sex : String, with name : String){
        let request : NSFetchRequest<Profile> = Profile.fetchRequest()
        request.returnsObjectsAsFaults = false
        saveData()
        do{
            let userProfileArray =  try context.fetch(request)
            if userProfileArray != [] {
                print(userProfileArray.count)
                userProfile = userProfileArray[0]
                userProfile?.sex = sex
                userProfile?.setValue(name, forKey: "name")
                saveData()
            }
        }catch {
            print ( "Error fetching data \(error)" )
        }

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
        saveData()
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
    
    func loadBodyParameters (with request : NSFetchRequest<BodyParameter> = BodyParameter.fetchRequest(),predicate: NSPredicate? = nil)
    {
        
        let parameterPredicate = NSPredicate(format: "parentProfile.name MATCHES %@", userProfile!.name!)
            request.predicate = parameterPredicate
        do{
          parameterArray =  try context.fetch(request)
            print(parameterArray.count)
        }catch {
            print (error)
        }
    }
}
