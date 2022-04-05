//
//  UIColor+CustomColors.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 05/04/2022.
//

import UIKit

extension UIColor{
    class func getCustomOrangeColor() -> UIColor{
        UIColor(named: "yellowUIColor") ?? UIColor.orange
    }
}
