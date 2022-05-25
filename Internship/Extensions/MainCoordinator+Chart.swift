//
//  MainCoordinator+Chart.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 07/04/2022.
//

import Foundation

extension MainCoordinator {
    func chart(_ parameter : BodyParameterModel, _ model : ProgressViewModel) {
        let vc = ChartViewController.instantiate()
        vc.coordinator = self
        vc.navigationItem.hidesBackButton = false
        vc.progressModel = model
        vc.bodyParameter = parameter
        vc.navigationController?.navigationBar.isHidden = false
        navigationController.pushViewController(vc, animated: false)
    }
}
