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
    var dates : [Date] = []
    var values : [Int32] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setUpCell(with parameter : BodyParameterModel?) {
        if let parameter = parameter {
            parameterValueLabel.text = "\(parameter.measureValue)"
            parameterMeasurementLabel.text = parameter.measuredIn ?? " "
            parameterNameLabel.text = parameter.parameterName ?? " "
            dates = parameter.dates
            values = parameter.values
        }
        parameterNameLabel.textColor = .white
        parameterMeasurementLabel.textColor = .white
        parameterValueLabel.textColor = UIColor.getCustomOrangeColor()
        self.layer.borderWidth = 1
        self.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.cornerRadius = 13
        valueChangedImage.layer.cornerRadius = 14
        valueDifferenceLabel.font = UIFont(name: "HelveticaNeue", size: 12.0)
        addCircle(values)
        valueDifferenceLabel.textColor = .white
        valueDifferenceLabel.contentMode = .center
    }
    func addCircle(_ values : [Int32]) {
        var progress : Int32
        let firstValue  : Int32
        let secondValue : Int32
        if values.count > 2 {
            firstValue  = values[values.count - 2]
            secondValue  = values[values.count - 1]
            progress = firstValue - secondValue
            if progress > 0 {
                valueDifferenceLabel.text = "+\(progress)"
                valueChangedImage.backgroundColor = .red
            }else {
                valueDifferenceLabel.text = String(progress)
                valueChangedImage.backgroundColor = .green
            }
        }else {
            valueDifferenceLabel.text = ""
            valueChangedImage.backgroundColor = .clear
        }
    }
}

