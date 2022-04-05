//
//  BodyParameter+CoreDataProperties.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 05/04/2022.
//
//

import Foundation
import CoreData


extension BodyParameter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BodyParameter> {
        return NSFetchRequest<BodyParameter>(entityName: "BodyParameter")
    }

    @NSManaged public var dates: [Date]
    @NSManaged public var isChosen: Bool
    @NSManaged public var isToggled: Bool
    @NSManaged public var measuredIn: String?
    @NSManaged public var measureValue: Int32
    @NSManaged public var parameterName: String?
    @NSManaged public var values: [Int32]
    @NSManaged public var parentProfile: Profile?

}

extension BodyParameter : Identifiable {

}
