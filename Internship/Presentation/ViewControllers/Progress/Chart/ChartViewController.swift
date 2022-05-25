//
//  ChartViewController.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 07/04/2022.
//

import UIKit

class ChartViewController: BaseViewViewController,Storyboarded {
    
    weak var coordinator : MainCoordinator?
    @IBOutlet weak var typeAndUnitLabel: UILabel!
    @IBOutlet weak var dateInformationLabel: UILabel!
    @IBOutlet weak var chartView: ChartView!
    var bodyParameter : BodyParameterModel?
    var progressModel : ProgressViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = bodyParameter?.parameterName
        setUp()
    }
    func setUp() {
        guard let progressModel = progressModel else {return}
        
        guard let bodyParameter = bodyParameter else {return}
        chartView.backgroundColor = .clear
        let dateString  = progressModel.getFormatedDateString(bodyParameter.dates.first ?? Date())
        typeAndUnitLabel.text = "\(bodyParameter.parameterName ?? ""),\(bodyParameter.measuredIn ?? "")"
        dateInformationLabel.text = "Displaying dynamics relative to data from \(dateString)"
        typeAndUnitLabel.font = UIFont.getCustomFont(.SairaRomanRegular, 24)
        dateInformationLabel.font = UIFont.getCustomFont(.SairaRomanMedium, 18)
        dateInformationLabel.textColor = UIColor(named: "descriptionText")
        dateInformationLabel.textAlignment = .center
        chartView.addScrollView(bodyParameter, Int(chartView.frame.height))
}
}
