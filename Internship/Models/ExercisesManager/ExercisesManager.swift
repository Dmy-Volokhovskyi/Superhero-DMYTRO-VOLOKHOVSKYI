//
//  ExercisesManager.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 12/04/2022.
//

import UIKit

class ExerciseManager {
    
    func loadJson() -> ExerciseModel? {
       let decoder = JSONDecoder()
       guard
            let url = Bundle.main.url(forResource: "Exercises", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let exercises = try? decoder.decode(ExerciseModel.self, from: data)
       else {
            return nil
       }
       return exercises
    }
    }
