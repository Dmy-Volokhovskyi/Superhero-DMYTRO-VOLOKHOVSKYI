//
//  Profile+CoreDataProperties.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 21/02/2022.
//
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var sex: String?
    @NSManaged public var name: String?

}

extension Profile : Identifiable {

}
