//
//  ExerciseMenuHeader.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 13/04/2022.
//

import UIKit

class ExerciseMenuHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var rollButton: UIButton!
    @IBOutlet weak var rollStateLine: UIView!
    @IBOutlet weak var muscleNameLabel: UILabel!
    @IBOutlet weak var selectedCounterLabel: UILabel!
    @IBOutlet weak var rollStateImage: UIImageView!
    
    var muscleViewModel : MuscleSectionViewModel!
    var selectedCounter = 0
    var changesMode = true
    
    var state = false {
        didSet{
            rollStateImage.image = state ? UIImage(named: "rollDown") : UIImage(named: "rollUp")
        }
    }
 
    static let reuseID = "ExerciseMenuHeader"
 
    var tapClosure: (() -> (Void))?
   
    @IBAction func rollButtonPressed(_ sender: UIButton) {

        tapClosure?()
    }
    
    func setUP(_ section : MuscleSectionViewModel) {
     
        muscleViewModel = section
        self.state = section.rollState
        rollButton.setTitle("", for: .normal)
        muscleNameLabel.text = section.name
        muscleNameLabel.font = UIFont.getCustomFont(.HelveticaNeueRegular, 18)
        muscleNameLabel.textColor = .white
        rollStateLine.backgroundColor = .white
        countSelected()
    }
    func countSelected () {
        selectedCounter = 0
        muscleViewModel.exercises?.filter({ exercise in
            if exercise.isSelected == true {
                selectedCounter += 1
            }
            return true
       })
        setSelectedCounter()
    }
    func setSelectedCounter () {
        if changesMode {
            selectedCounterLabel.text = "Selected \(selectedCounter)"
            print("Selected \(selectedCounter)")
        }else {
            selectedCounterLabel.text = ""
        }
    }
}
