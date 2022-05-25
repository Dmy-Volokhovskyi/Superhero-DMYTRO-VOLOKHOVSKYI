//
//  ExerciseModel.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 12/04/2022.
//

import Foundation

// MARK: - ExerciseModelElement
struct ExerciseModelElement: Codable {
    let muscleName: String?
    let exercisesList: [ExercisesList]?
}

// MARK: - ExercisesList
struct ExercisesList: Codable {

    let name: String?
    let imageIcon: ImageIcon?
    let exerciseImage, descriptions: String?
    let exerciseType: ExerciseType?
    let equipment: Equipment?
    let level: Level?
}

enum Equipment: String, Codable {
    case weights = "Гантели"
    case ownWeight = "Собственный вес"
    case trainer = "Тренажер"
    case barbell = "Штанга"
}

enum ExerciseType: String, Codable {
    case bodybuilding = "Бодибилдинг"
    case powerlifting = "Пауeрліфтінг"
}

enum ImageIcon: String, Codable {
    case dumbbell = "dumbbell"
    case fitness = "fitness"
    case stopwatch = "stopwatch"
}

enum Level: String, Codable {
    case Barbell = "Новичок"
    case Normal = "Обычный"
    case Bpodybuilder = "Опытный"
}

typealias ExerciseModel = [ExerciseModelElement]


