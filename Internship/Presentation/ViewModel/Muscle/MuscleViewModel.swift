//
//  MuscleViewModel.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 22/02/2022.
//
import UIKit

class MuscleViewModel {
    
    var profile  = ProfileManager.sharedInstance.userProfile
    let barButtonTitle = "Muscle"
    let girlImage = UIImage(named: "girlBackgroundCut")
    let manlImage = UIImage(named: "manBackgroundCut")
    let exerciseMAnager = ExerciseManager()
    var exercisesArray : [ExerciseModelElement] = []
    var muscleSectionViewModels : [MuscleSectionViewModel] = []
    var generalSectionsArray : [MuscleSectionViewModel] = []


    
    func getbackgroundImage () -> UIImage? {
        if profile?.sex == "SUPERGIRL"{
            return girlImage
        }else {
            return manlImage
        }
    }
    func getExercises(){
        exercisesArray = exerciseMAnager.loadJson()!
    }
    
    init () {
        getExercises()
        createSectionModels()
        generalSectionsArray = muscleSectionViewModels
        fillGeneralArray()
    }
    
    func fillExerciseData(wiht sectionNumber : Int, and state : Bool)  {
        muscleSectionViewModels[sectionNumber].rollState = state
        if muscleSectionViewModels[sectionNumber].rollState {
            muscleSectionViewModels[sectionNumber].exercises = (generalSectionsArray.count>0 ?  generalSectionsArray[sectionNumber].exercises : createNewExercises(with: sectionNumber) )
        }else {
            muscleSectionViewModels[sectionNumber].exercises = []
        }
        muscleSectionViewModels[sectionNumber].rollState = !muscleSectionViewModels[sectionNumber].rollState
        generalSectionsArray[sectionNumber].rollState = !generalSectionsArray[sectionNumber].rollState
    }
    
    func createSectionModels() {
        for exercise in exercisesArray {
            let newSectionModel = MuscleSectionViewModel(name: exercise.muscleName ?? " ", isSelectedCounter: 0, rollState: true, exercises: [])
            muscleSectionViewModels.append(newSectionModel)
        }
    }
    
    func createNewExercises(with exercisesListIndex : Int) -> [ExerciseCellViewModel] {
        if let newExercises = exercisesArray[exercisesListIndex].exercisesList {
        var returnExercises : [ExerciseCellViewModel] = []
        for exercise in 0...newExercises.count - 1 {
            let newEX = ExerciseCellViewModel(image: newExercises[exercise].imageIcon ?? .dumbbell,
                                              isSelected: false,
                                              description: newExercises[exercise].descriptions ?? " " ,
                                              name: newExercises[exercise].name ?? " " ,
                                              exerciseImage: newExercises[exercise].exerciseImage ?? " ",
                                              exerciseType: (newExercises[exercise].exerciseType ?? .powerlifting).rawValue,
                                              equipment: (newExercises[exercise].equipment ?? .weights).rawValue,
                                              level: (newExercises[exercise].level ?? .Barbell).rawValue)
            returnExercises.append(newEX)
        }
        
        return returnExercises
        }else{
            return []
        }
    }
    func changeTrueToFalse(_ section : Int, _ row : Int) {
        guard let exercise = generalSectionsArray[section].exercises?[row] else {return}
        generalSectionsArray[section].exercises?[row].isSelected = !exercise.isSelected
        print(muscleSectionViewModels[section].exercises?[row].isSelected)
    }
    func fillGeneralArray () {
        for section  in 0...generalSectionsArray.count - 1 {
            generalSectionsArray[section].exercises = createNewExercises(with: section)
        }
    }
}

