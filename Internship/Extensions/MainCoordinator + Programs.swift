//
//  MainCoordinator + Programs.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 22/02/2022.
//

import Foundation
extension MainCoordinator {
    func programs() {
        let vc = ProgramsViewController.instantiate()
        vc.coordinator = self
        vc.navigationItem.hidesBackButton = false
        vc.navigationController?.navigationBar.isHidden = false
        navigationController.pushViewController(vc, animated: false)
    }
}
