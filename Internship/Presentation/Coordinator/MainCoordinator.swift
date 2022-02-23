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
        
        ProfileManager.sharedInstance.loadProfileInformation()
        if ProfileManager.sharedInstance.userProfile != nil {
            home()
        } else {
            let vc = StartViewController.instantiate()
            vc.coordinator = self
            navigationController.pushViewController(vc, animated: false)
        }
    }
    
    private func home() {
        let vc = HomeScreenViewController.instantiate()
        vc.coordinator = self
        vc.navigationItem.hidesBackButton = true
        vc.navigationController?.navigationBar.isHidden = true
        vc.navigationController?.hidesBarsOnSwipe = true
        navigationController.pushViewController(vc, animated: false)
    }
}
