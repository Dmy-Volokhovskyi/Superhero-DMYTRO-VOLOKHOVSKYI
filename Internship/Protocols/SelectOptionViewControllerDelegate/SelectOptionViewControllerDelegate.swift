//
//  SelectOptionViewControllerDelegate.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 05/04/2022.
//

import Foundation
protocol SelectOptionViewControllerDelegate:AnyObject {
    func didUpdateOperableArray(operableArray : [BodyParameterModel])
}
