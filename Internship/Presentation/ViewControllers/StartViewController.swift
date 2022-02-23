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
        bottomManGradient.addGradient(colors: [.black, UIColor.clear], locations: [0.27,1], startPoint: CGPoint(x: 0.0, y: 1.0), endPoint: CGPoint(x: 0.0, y: 0.0), type: .axial)
        supermanButton.layer.cornerRadius = supermanButton.frame.size.height/2
        supergirlButton.layer.cornerRadius = supergirlButton.frame.size.height/2
    }
    //MARK: - Configure interface.
    private func configureUI() {
        //set man button title
        supermanButton.setTitle(viewModel.manButtonTitle.uppercased(), for: .normal)
        supermanButton.titleLabel?.textColor = .black
        supermanButton.titleLabel?.font = UIFont(name: "SairaRoman-Regular", size: 18)
        //set gitl button title
        supergirlButton.setTitle(viewModel.girlButtonTitle.uppercased(), for: .normal)
        supermanButton.titleLabel?.textColor = .black
        supermanButton.titleLabel?.font = UIFont(name: "SairaRoman-Regular", size: 18)
        //set main label text
        mainTitleLabel.text = viewModel.mainTitle.uppercased()
        mainTitleLabel.textColor = UIColor(named: "yellowUIColor") ?? UIColor.yellow
        mainTitleLabel.font = UIFont(name: "Futura-Bold", size: 32)
        // set Choose hero text
        chooseHereLabel.text = viewModel.chooseHeroTitle
        chooseHereLabel.textColor = .white
        chooseHereLabel.font = UIFont(name: "SairaRoman-Regular", size: 16)
        girlBackground.image = viewModel.girlBackgroundImage
        manBackground.image = viewModel.manBackgroundImage
        
    }
    // Check if there is any profile set
    @IBAction private func genderChosenPressed(_ sender: UIButton) {
        viewModel.chooseSex(with: sender.titleLabel?.text ?? "")
        coordinator?.start()
    }
}

