//
//  MainMenuHeaderDelegate.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 17/03/2022.
//

import Foundation
import UIKit

protocol MainMenuHeaderDelegate {
    func gotData (_ mainMenuHeader : MainMenuHeader, _ value : String, _ buttonState : Bool)
    func presentImagePicker ()
}
