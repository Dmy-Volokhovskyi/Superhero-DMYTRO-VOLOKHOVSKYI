//
//  AnimationManager.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 18/03/2022.
//

import UIKit

import UIKit

class PanelTransition: NSObject, UIViewControllerTransitioningDelegate {
    
    // MARK: - Presentation controller
//    private let driver = TransitionDriver()
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        
        let presentationController = DimmPresentationController(presentedViewController: presented,
                                                                presenting: presenting ?? source)
       
        return presentationController
    }
    
    // MARK: - Animation
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAnimation()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimation()
    }
    

}

