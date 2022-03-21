//
//  BodyParameter+CoreDataProperties.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 20/03/2022.
//
//

import Foundation
import CoreData


extension BodyParameter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BodyParameter> {
        return NSFetchRequest<BodyParameter>(entityName: "BodyParameter")
    }

    @NSManaged public var parameterName: String?
    @NSManaged public var measuredIn: String?
    @NSManaged public var measureValue: String?
    @NSManaged public var isChosen: Bool
    @NSManaged public var parentProfile: Profile?

}

extension BodyParameter : Identifiable {

}
