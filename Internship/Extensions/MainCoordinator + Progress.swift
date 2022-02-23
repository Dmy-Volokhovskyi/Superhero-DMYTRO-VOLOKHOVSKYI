//
//  MainCoordinator + Progress.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 22/02/2022.
//

import Foundation
extension MainCoordinator {
     func progress() {
        let vc = ProgressViewController.instantiate()
        vc.coordinator = self
        vc.navigationItem.hidesBackButton = false
        navigationController.pushViewController(vc, animated: false)
      }
}
