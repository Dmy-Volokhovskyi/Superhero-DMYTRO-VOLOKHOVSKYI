//
//  ViewController.swift
//  Internship
//
//  Created by Дмитро Волоховський on 15/02/2022.
//

import UIKit

class StartViewController: UIViewController,Storyboarded {

    @IBOutlet weak var topGirlGradient: UIImageView!
    @IBOutlet weak var bottomManGradient: UIImageView!
    @IBOutlet weak var supergirlButton: UIButton!
    @IBOutlet weak var supermanButton: UIButton!
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var chooseHereLabel: UILabel!
    @IBOutlet weak var girlBackground: UIImageView!
    @IBOutlet weak var manBackground: UIImageView!
    
    weak var coordinator : MainCoordinator?
    let viewModel = StartViewModel()
    
    override func viewDidLoad() {
        configureUI()
    }
    override func viewDidLayoutSubviews() {
        topGirlGradient.addGradient()
        bottomManGradient.addGradient(colors: [.black, UIColor.clear], locations: [0,0.83,1], startPoint: CGPoint(x: 0.0, y: 1.0), endPoint: CGPoint(x: 0.0, y: 0.0), type: .axial)
        supermanButton.layer.cornerRadius = supermanButton.frame.size.height/2
        supergirlButton.layer.cornerRadius = supergirlButton.frame.size.height/2
    }
    //MARK: - Configure interface.
    private func configureUI() {
        supermanButton.setAttributedTitle(viewModel.manButtonTitle, for: .normal)
        supergirlButton.setAttributedTitle(viewModel.girlButtonTitle, for: .normal)
        mainTitleLabel.attributedText = viewModel.mainTitle
        chooseHereLabel.attributedText = viewModel.chooseHeroTitle
        girlBackground.image = viewModel.girlBackgroundImage
        manBackground.image = viewModel.manBackgroundImage
        
    }
    // Check if there is any profile set
    @IBAction private func genderChosenPressed(_ sender: UIButton) {
        viewModel.chooseSex(with: sender.titleLabel?.text ?? "")
        coordinator?.start()
    }
}

