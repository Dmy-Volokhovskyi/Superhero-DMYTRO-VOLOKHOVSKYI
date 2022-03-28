//
//  ParametersCollectionViewCell.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 27/03/2022.
//

import UIKit

class ParametersCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var valueChangedImage: UIImageView!
    @IBOutlet weak var valueDifferenceLabel: UILabel!
    @IBOutlet weak var parameterMeasurementLabel: UILabel!
    @IBOutlet weak var parameterValueLabel: UILabel!
    @IBOutlet weak var parameterNameLabel: UILabel!
    
    static let cellID = "ParametersCollectionViewCell"
    var toggledParametersArray : BodyParameterModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setUpCell(with parameter : BodyParameterModel?) {
        if let parameter = parameter {
            parameterValueLabel.text = "120"
            parameterMeasurementLabel.text = parameter.measuredIn ?? " "
            parameterNameLabel.text = parameter.parameterName ?? " "
        }
        parameterNameLabel.textColor = .white
        parameterMeasurementLabel.textColor = .white
        parameterValueLabel.textColor = UIColor(named: "yellowUIColor")
        self.layer.borderWidth = 1
        self.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.cornerRadius = 13
        
    }
}
