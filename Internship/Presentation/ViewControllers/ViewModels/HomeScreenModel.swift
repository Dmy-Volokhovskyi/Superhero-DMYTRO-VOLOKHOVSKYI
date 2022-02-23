//
//  HomeScreenViewModel.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 21/02/2022.
//

import Foundation
import UIKit

struct HomeScreenModel {
    
    let menuArray = ["Профиль","Прогресс","Программы","Калькулятор","Мышцы"]
    let reuseIdentifier = "Cell"
    let cellNibName = "MenuCell"
    let girlImage = UIImage(named: "girlBackgroundCut")
    let manlImage = UIImage(named: "manBackgroundCut")
    let manTitle = "Superman"
    let girlTitle = "Supergirl"
}
