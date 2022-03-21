//
//  AnimationManager.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 18/03/2022.
//

import UIKit
final class AnimationManager: NSObject {

    // MARK: - Variables
    private let animationDuration: Double
    private let animationType: AnimationType

    // MARK: - Init
    init(animationDuration: Double, animationType: AnimationType) {
        self.animationDuration = animationDuration
        self.animationType = animationType
    }
    enum AnimationType {
        case present
        case dismiss
    }
}
extension AnimationManager: UIViewControllerAnimatedTransitioning {
    // Return the animation duration defined when we instantiated the view.
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(exactly: animationDuration) ?? 3
    }

    // Retrieve the ViewControllers and call the animation method
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let toViewController = transitionContext.viewController(forKey: .to),
            let fromViewController = transitionContext.viewController(forKey: .from)
        else {
            // We only complete transition with success if the transition was executed.
            
            transitionContext.completeTransition(false)
            return
        }

        // According to the animation type we call the method to animate the presenting or dismissing.
        switch animationType {
        case .present:
            presentAnimation(
                transitionContext: transitionContext,
                fromView: fromViewController,
                toView: toViewController
            )
        case .dismiss:
            dismissAnimation(
                transitionContext: transitionContext,
                fromView: fromViewController,
                toView: toViewController
            )
        }
    }
    
    func presentAnimation (transitionContext : UIViewControllerContextTransitioning,fromView: UIViewController,toView:UIViewController) {
        // Assigning the context to a variable.
        let containerView = transitionContext.containerView
        print("Works")
        // We split the whole animation in 2 different parts.
        // The fist part should run in 1/3 of the time and the second part 2/3 of the time.
        let firstPartDuration = (animationDuration / 3)

        
        // Cast the ViewControllers to their original type
        guard let fromVC = fromView as? ProfileViewController else { return }
        guard let toVC = toView as? ProfileViewController else { return }
        // Mirroring the objects that we will animate.
        let backgroundView = UIView()
        // Storing the frame positions.
        let backgroundFrame = containerView.convert(
            fromVC.menuTableView.frame,
            from: fromVC.backgroundView.superview
        )

        backgroundView.frame = CGRect(x: 23, y: 78, width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height - 150)

        backgroundView.backgroundColor = .black
        backgroundView.layer.cornerRadius = 13
        toView.view.addSubview(backgroundView)
        let tableView = SelectOptionTableVIew(frame: CGRect.zero, style: .grouped)
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height - 150)
                                              
        tableView.layer.cornerRadius = 13
        tableView.setupTableView()
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height - 150)
        backgroundView.addSubview(tableView)
        
        
        

        // Hidding/Showing objects to not/be displayed while animating the transition.
        fromVC.view.isHidden = false
        toVC.view.isHidden = false

        

        // Background view final position.
        let frameAnim = CGRect(x: 23, y: 78, width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height - 150)

        containerView.addSubview(toView.view)
        backgroundView.frame = frameAnim

        transitionContext.completeTransition(true)

    }
    func dismissAnimation(transitionContext: UIViewControllerContextTransitioning,
                          fromView: UIViewController,
                          toView: UIViewController) {

        let containerView = transitionContext.containerView

        containerView.addSubview(toView.view)
        containerView.addSubview(fromView.view)

        // We'll not animate anything. This will be covered in the next part of the article.
        transitionContext.completeTransition(true)
    }
}
