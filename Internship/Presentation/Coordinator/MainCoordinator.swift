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
        vc.navigationController?.navigationBar.isHidden = false
        navigationController.navigationBar.tintColor = UIColor(named: "yellowUIColor")
        //Can't Get them to have the style I want
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont(name: "SairaRoman-Medium", size: 18)!]
        navigationController.navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "AvenirNextCondensed-DemiBoldItalic", size: 40)!], for: .normal)
        navigationController.pushViewController(vc, animated: false)
    }
    
    
    
     func showOptions () {
        let vc = ProfileViewController.instantiate()
        vc.coordinator = self
  

        vc.navigationController?.navigationBar.isHidden = true
        navigationController.pushViewController(vc, animated: true)
    }
}
