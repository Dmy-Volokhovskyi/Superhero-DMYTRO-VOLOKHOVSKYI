//
//  ChartViewModel.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 08/04/2022.
//


import UIKit


struct ChartSegmentViewModel {
    
    let value : Int32
    let date : String
    let backgroundColor : UIColor
    let difference : String
    
    init(_ currentValue : Int32,_ previousValue : Int32, _ date : Date, _ diff : Int) {
         
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd"
        self.date = formatter.string(from: date)
        self.value = currentValue
        
        let diff = diff
        if diff > 0 {
            self.difference = "+\(diff)"
            self.backgroundColor = .red
        }else if (diff) < 0 {
            self.difference = "\(diff)"
            self.backgroundColor = .green
        } else{
            self.difference = ""
            self.backgroundColor = .clear
        }
    }
}
