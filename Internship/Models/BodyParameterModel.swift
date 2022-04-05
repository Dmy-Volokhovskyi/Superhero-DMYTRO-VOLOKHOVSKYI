//
//  BodyParameterModel.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 23/03/2022.
//

import Foundation
struct BodyParameterModel : Equatable {
    
    var parameterName: String?
    var measuredIn: String?
    var measureValue: Int32
    var isChosen: Bool
    var isToggled : Bool
    var values: [Int32]
    var dates: [Date]
    
    init(model: BodyParameter) {
        parameterName = model.parameterName
        measuredIn = model.measuredIn
        measureValue = model.measureValue
        isChosen = model.isChosen
        isToggled = model.isToggled
        values = model.values
        dates = model.dates
    }
}
