//
//  DimmView.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 29/03/2022.
//

import UIKit

class DimmPresentationController: PresentationController
{
    private lazy var dimmView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        view.alpha = 0
        return view
    }()
}
