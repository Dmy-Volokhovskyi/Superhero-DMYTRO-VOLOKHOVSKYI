//
//  InformationAllertView.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 07/04/2022.
//

import UIKit

class InformationAllertViewController : UIViewController, Storyboarded  {
    
    @IBOutlet weak var viewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var informationImage: UIImageView!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.title = "Allert Shown Heja"
        
    }
    enum allertType {
        case sucess, lackOfInformation
    }
    
    func createAllertView (_ type : allertType, _ height : CGFloat) {
        
        switch type {
        case .sucess:
            informationImage.image = UIImage(systemName: "checkmark.circle")
            informationLabel.text = "Profile has been saved!"
        case .lackOfInformation:
            informationImage.image = UIImage(systemName: "exclamationmark.circle")
            informationLabel.text = "Options are not selected.To display them, add them to your profile."
        }
        backgroundView.backgroundColor = .black
        informationLabel.font = UIFont.getCustomFont(.HelveticaNeueRegular, 16)
        informationImage.tintColor = UIColor.getCustomOrangeColor()
        informationLabel.numberOfLines = 3
        viewHeightConstraint.constant = height
    }
}
