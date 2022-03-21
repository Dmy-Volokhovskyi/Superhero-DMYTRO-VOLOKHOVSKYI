//
//  BaseViewViewController.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 16/03/2022.
//

import UIKit

class BaseViewViewController: UIViewController, Storyboarded  {

   private let backgroundImage = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    // Add Image Method
    func addImage (_ imageName : String) {
        view.insertSubview(backgroundImage, at: 0)
        backgroundImage.frame = view.frame
        backgroundImage.image = UIImage(named: imageName)
        backgroundImage.contentMode = .scaleToFill
        backgroundImage.addGradient(colors: [.black, UIColor.clear], locations: [0.27,1], startPoint: CGPoint(x: 0.0, y: 1.0), endPoint: CGPoint(x: 0.0, y: 0.0), type: .axial, frame: backgroundImage.frame)
        view.insertSubview(backgroundImage, at: 0)
 
    }
}
