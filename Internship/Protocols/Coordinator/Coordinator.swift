//
//  Coordinator.swift
//  Internship
//
//  Created by Дмитро Волоховський on 15/02/2022.
//

import Foundation
import UIKit
protocol Coordinator {
    var childCoordinators : [Coordinator] {get set}
    var navigationController : UINavigationController{get set}
    func start()
}
