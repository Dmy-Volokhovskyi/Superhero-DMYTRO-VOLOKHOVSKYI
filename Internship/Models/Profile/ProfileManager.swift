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
    
    lazy var mainContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Profile")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                print("Error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var operableArray : [BodyParameterModel] = []
    
    var userProfile : Profile?
    
    var parameterArray : [BodyParameter] = []
    
    //    MARK: -
    func createDefaultProfile (with sex : String) {
        userProfile = Profile(context: mainContext)
        userProfile?.sex = sex
        userProfile?.name = nil
        userProfile?.parameters = nil
        saveData()
    }
    
    func saveData() {
        guard mainContext.hasChanges else { return }
        do {
            try mainContext.save()
        }catch let error as NSError{
            print("Error saving Context \(error.localizedDescription)")
        }
    }
    
    func loadProfileInformation() {
        let request : NSFetchRequest<Profile> = Profile.fetchRequest()
        request.returnsObjectsAsFaults = false
        do{
            let userProfileArray =  try mainContext.fetch(request)
            if userProfileArray != [] {
                userProfile = userProfileArray[0]
            }
        }catch {
            print ( "Error fetching data \(error)" )
        }
        if userProfile?.parameters == [] {
            userProfile?.parameters = BodyParameterStorage.sharedInstance.getBodyParameters()
        }
    }
    
    func saveParameterChanges(newParameters : [BodyParameter]?, and name : String?, and profileImage : Data?) {
        userProfile?.setValue(name, forKey: "name")
        userProfile?.setValue(profileImage, forKey: "profileImage")
        if let newParameters = newParameters {
            userProfile?.parameters = NSOrderedSet(array: newParameters)
        }
        saveData()
    }
    
    func getUnwreppedImage () -> UIImage? {
        if userProfile?.profileImage != nil {
            let image = UIImage(data: (userProfile?.profileImage)!)
            return image!
        }
        return nil
    }
}
