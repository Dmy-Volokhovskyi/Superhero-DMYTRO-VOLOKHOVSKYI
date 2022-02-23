//
//  MainCoordinator+Calculator.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 22/02/2022.
//

import Foundation
extension MainCoordinator {
     func calculator() {
        let vc = CalculatorViewController.instantiate()
        vc.coordinator = self
        vc.navigationItem.hidesBackButton = false
        navigationController.pushViewController(vc, animated: false)
      }
}
