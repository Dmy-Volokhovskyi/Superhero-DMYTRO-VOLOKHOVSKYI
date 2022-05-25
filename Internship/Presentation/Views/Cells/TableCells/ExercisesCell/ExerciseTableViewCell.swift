//
//  ExerciseTableViewCell.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 13/04/2022.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {
    
    static let cellID = "ExerciseTableViewCell"
    
    @IBOutlet weak var backgroundContainerView: UIView!
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var levelsLabel: UILabel!
    @IBOutlet weak var equipmetImage: UIImageView!
    @IBOutlet weak var isSelectedImage: UIImageView!
    @IBOutlet weak var moreAboutLabel: UILabel!
    
    var changesMode = true
    var cellModel : ExerciseCellViewModel?
    var CGWhite = UIColor.white.cgColor
    var CGOrange = UIColor.getCustomOrangeColor().cgColor
    var changeIsSelected: (() -> (Void))?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // arrow.right
    }
    
    func setUp(with cellModel : ExerciseCellViewModel) {
        self.cellModel = cellModel
        exerciseLabel.text = cellModel.name
        exerciseLabel.textColor = .white
        exerciseLabel.font = UIFont(name: "Saira-Regular", size: 18)
        
        equipmetImage.image = UIImage(named: "dumbbell")
        levelsLabel.text = "\(cellModel.level)"
        levelsLabel.textColor = UIColor.getCustomOrangeColor()
        levelsLabel.font = UIFont(name: "Nunito-Light", size: 14)
        
        moreAboutLabel.text = "More About →"
        moreAboutLabel.textColor = UIColor.getCustomOrangeColor()
        moreAboutLabel.font = UIFont(name: "Nunito-Light", size: 16)
        
        backgroundColor = .clear
        backgroundContainerView.backgroundColor = .clear
        backgroundContainerView.layer.cornerRadius = 13
        backgroundContainerView.layer.borderWidth = 1
        backgroundContainerView.layer.borderColor = UIColor.white.cgColor
        setBorderAndImage()
        print(cellModel.isSelected)
        
    }
    
    @IBAction func selectButtonPresed(_ sender: UIButton) {
        print("selected")
        guard let cellModel = cellModel else {return}
        changeIsSelected!()
        self.cellModel?.isSelected = !cellModel.isSelected
        print(cellModel.isSelected)
        setBorderAndImage()
    }
    @IBAction func moreAboutButtonPressed(_ sender: UIButton) {
        print("moreAbout")
    }
    func setBorderAndImage() {
        guard let cellModel = cellModel else {return}
        if changesMode {
            backgroundContainerView.layer.borderColor = cellModel.isSelected ?  CGOrange : CGWhite
            isSelectedImage.image = cellModel.isSelected ?  UIImage(named: "Check") : UIImage()
        }else{
            backgroundContainerView.layer.borderColor = UIColor.white.cgColor
        }
    }
}
