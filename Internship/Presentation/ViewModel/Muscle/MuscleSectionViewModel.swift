//
//  SectionViewModel.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 17/04/2022.
//

import Foundation

struct MuscleSectionViewModel {
    var name : String
    var isSelectedCounter : Int
    var rollState : Bool
    var exercises : [ExerciseCellViewModel]?
    
}
