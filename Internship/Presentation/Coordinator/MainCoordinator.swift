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
    
    func back() {
        navigationController.popViewController(animated: true)
    }
    
    private func home() {
        let vc = HomeScreenViewController.instantiate()
        vc.coordinator = self
        vc.navigationItem.hidesBackButton = true
        vc.navigationController?.navigationBar.isHidden = false
        navigationController.navigationBar.tintColor = UIColor.getCustomOrangeColor()
        //Can't Get them to have the style I want
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.getCustomFont(.SairaRomanMedium, 18)]
        navigationController.navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.getCustomFont(.AvenirNextCondensedDemiBoldItalic, 40)], for: .normal)
        navigationController.pushViewController(vc, animated: false)
    }
    
    
    func showOptions (model : ProfileViewModel, with profileVC: ProfileViewController, and array :[BodyParameterModel]) {
        let vc = SelectOptionsViewController.instantiate()
        vc.coordinator = self
        vc.viewModel = model
        vc.delegate = profileVC
        vc.operableArray = array
        navigationController.modalPresentationStyle = .custom
        navigationController.pushViewController(vc, animated: true)
    }
}
