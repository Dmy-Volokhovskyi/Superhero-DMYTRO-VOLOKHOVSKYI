//
//  UIFont + appFonts.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 05/04/2022.
//

import UIKit

extension UIFont {
    
    enum font {
        case HelveticaNeue,HelveticaNeueRegular, SairaRomanMedium,SairaRomanRegular, FuturaBold,AvenirNextCondensedDemiBoldItalic
    }
    
    class func getCustomFont(_ font : font, _ size : CGFloat) -> UIFont{
        switch font {
        case .HelveticaNeue:
            return UIFont(name: "HelveticaNeue", size: size) ?? UIFont()
        case .SairaRomanMedium:
            return UIFont(name: "SairaRoman-Medium", size: size) ?? UIFont()
        case .HelveticaNeueRegular:
            return UIFont(name: "HelveticaNeue-Regular", size: size) ?? UIFont(name: "HelveticaNeue", size: size) ?? UIFont()
        case .SairaRomanRegular:
            return UIFont(name: "SairaRoman-Regular", size: size) ?? UIFont()
        case .FuturaBold:
            return UIFont(name: "Futura-Bold", size: size) ?? UIFont()
        case .AvenirNextCondensedDemiBoldItalic:
            return UIFont(name: "AvenirNextCondensed-DemiBoldItalic", size: size) ?? UIFont()
        }
}
}



