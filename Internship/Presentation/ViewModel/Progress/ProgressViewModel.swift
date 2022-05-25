//
//  ProgressViewModel.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 22/02/2022.
//

import UIKit

class ProgressViewModel {
    
    let barButtonTitle = "Progress"
    let profile = ProfileManager.sharedInstance.userProfile
    let girlImage = UIImage(named: "girlBackgroundCut")
    let manlImage = UIImage(named: "manBackgroundCut")
    var toggledArray : [BodyParameterModel] = []
    var dataEntries : [ChartSegmentViewModel] = []
    
    
    init () {
        self.toggledArray = BodyParameterStorage.sharedInstance.toggledArray
    }
    
    func getbackgroundImage () -> UIImage? {
        if profile?.sex == "SUPERGIRL"{
            return girlImage
        }else {
            return manlImage
        }
    }
    
    func getFormatedDateString(_ date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    func formDataEntries(_ bodyParameterModel : BodyParameterModel) {
        var valuesArray = bodyParameterModel.values
        var datesArray = bodyParameterModel.dates
        var firstValue : Int32
        var secondValue : Int32
        var date : Date
        while valuesArray.count != 0 && datesArray.count != 0 {
            firstValue = valuesArray.first ?? 0
            date = datesArray.first ?? Date()
            valuesArray.removeFirst()
            secondValue = valuesArray.first ?? 0
            let  newSegment = ChartSegmentViewModel(firstValue, secondValue, date, 0)
            datesArray.removeFirst()
            dataEntries.append(newSegment)
        }
    }
}
