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
    
    
    func createDefaultProfile (with sex : String) {
        print(sex)
        userProfile = Profile(context: context)
        userProfile?.sex = sex
        saveProfile()
    }
    
    func saveProfile() {
        do {
          try context.save()
        }catch{
            print("Error saving Context \(error)")
        }
    }
    
    func loadProfileInformation() {
        let request : NSFetchRequest<Profile> = Profile.fetchRequest()
        request.returnsObjectsAsFaults = false
        saveProfile()
        do{
            let userProfileArray =  try context.fetch(request)
            if userProfileArray != [] {
                userProfile = userProfileArray[0]
                print(userProfileArray)
            }
        }catch {
            print ( "Error fetching data \(error)" )
        }
    }
}
