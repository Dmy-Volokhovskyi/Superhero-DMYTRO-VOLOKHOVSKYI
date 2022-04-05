//
//  SettingCellDelegate .swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 05/04/2022.
//

import Foundation

protocol SettingsTableViewCellDelegate {
    func didChangeValue(with localIndex : Int , and valeue : Bool)
    func checkNumbers(with localIndex : Int ,and value : Int32, _ values : [Int32], _ dates : [Date])
    func keyboardIsShown(sender: NSNotification)
    func keyboardIsHidden(sender: NSNotification)
}
