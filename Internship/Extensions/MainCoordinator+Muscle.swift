//
//  MainCoordinator+Muscle.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 22/02/2022.
//

import Foundation
extension MainCoordinator {
     func muscle() {
        let vc = MuscleViewController.instantiate()
        vc.coordinator = self
        vc.navigationItem.hidesBackButton = false
        navigationController.pushViewController(vc, animated: false)
      }
}
