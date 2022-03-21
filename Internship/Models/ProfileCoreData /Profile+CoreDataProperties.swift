//
//  Profile+CoreDataProperties.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 20/03/2022.
//
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var name: String?
    @NSManaged public var sex: String?
    @NSManaged public var parentProfile: NSSet?

}

// MARK: Generated accessors for parentProfile
extension Profile {

    @objc(addParentProfileObject:)
    @NSManaged public func addToParentProfile(_ value: BodyParameter)

    @objc(removeParentProfileObject:)
    @NSManaged public func removeFromParentProfile(_ value: BodyParameter)

    @objc(addParentProfile:)
    @NSManaged public func addToParentProfile(_ values: NSSet)

    @objc(removeParentProfile:)
    @NSManaged public func removeFromParentProfile(_ values: NSSet)

}

extension Profile : Identifiable {

}
