//
//  MainCoordinator.swift
//  Internship
//
//  Created by Дмитро Волоховський on 15/02/2022.
//

import Foundation
import UIKit

class MainCoordinator : Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController : UINavigationController){
        self.navigationController = navigationController
    }
    
    
    func start() {
        let vc = ViewController.instantiate()
        navigationController.pushViewController(vc, animated: false)
    }
    
     
}
