//
//  SelectOptionsViewController.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 21/03/2022.
//

import UIKit
import CoreData

class SelectOptionsViewController : BaseViewViewController, Storyboarded {
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var optionsTableView: UITableView!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var tableBackgroundView: UIView!
    
    var viewModel : ProfileViewModel?
    weak var delegate : SelectOptionViewControllerDelegate?
    var operableArray = [BodyParameterModel]()
    weak var coordinator : MainCoordinator?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel = viewModel else { return self.dismiss(animated: true)}
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
        
        operableArray = viewModel.bodyparameterViewModel
        optionsTableView.bounces = false
        optionsTableView.register(UINib.init(nibName: SelectOptionTableViewCell.cellID, bundle: nil), forCellReuseIdentifier: SelectOptionTableViewCell.cellID)
        optionsTableView.backgroundColor = .clear
        tableBackgroundView.layer.borderWidth = 1
        tableBackgroundView.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        tableBackgroundView.backgroundColor = .black
        tableBackgroundView.layer.cornerRadius = 13
        cancelButton.setTitle(viewModel.cancelButtonText, for: .normal)
        cancelButton.tintColor = .white
        selectButton.setTitle(viewModel.selectButtonTitle, for: .normal)
        selectButton.tintColor = UIColor.getCustomOrangeColor()
        titleLabel.text = viewModel.selectOptionTile
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.getCustomOrangeColor()
        titleLabel.font = UIFont.getCustomFont(.SairaRomanRegular, 16)
        optionsTableView.reloadData()
    }
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func selectButtonPressed(_ sender: Any) {
        self.delegate?.didUpdateOperableArray(operableArray: operableArray)
        self.dismiss(animated: true)
    }
    
}
extension SelectOptionsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {return 0}
        return viewModel.bodyparameterViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectOptionTableViewCell.cellID, for: indexPath) as! SelectOptionTableViewCell
        guard let viewModel = viewModel else {return SelectOptionTableViewCell()}
        cell.setUp(parameter: viewModel.bodyparameterViewModel[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewModel = viewModel {
            viewModel.bodyparameterViewModel[indexPath.row].isChosen = !viewModel.bodyparameterViewModel[indexPath.row].isChosen
            optionsTableView.reloadData()
        }
    }
}
