//
//  PresentationController.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 29/03/2022.
//

import UIKit

class PresentationController: UIPresentationController {
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let bounds = containerView!.bounds
        let height = bounds.height
        return CGRect(x: 0,
                             y: 0,
                             width: bounds.width,
                             height: height)
    }
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        containerView?.addSubview(presentedView!)
    }
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
}
