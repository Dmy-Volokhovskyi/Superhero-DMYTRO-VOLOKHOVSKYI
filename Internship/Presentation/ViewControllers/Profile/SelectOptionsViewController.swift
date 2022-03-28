//
//  SelectOptionsViewController.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 21/03/2022.
//

import UIKit
import CoreData

protocol SelectOptionViewControllerDelegate:AnyObject {
    func didUpdateOperableArray(operableArray : [BodyParameterModel])
}


class SelectOptionsViewController : BaseViewViewController {
    
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
         
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
        
        optionsTableView.bounces = false
        optionsTableView.register(UINib.init(nibName: SelectOptionTableViewCell.cellID, bundle: nil), forCellReuseIdentifier: SelectOptionTableViewCell.cellID)
        optionsTableView.backgroundColor = .clear
        tableBackgroundView.layer.borderWidth = 1
        tableBackgroundView.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        tableBackgroundView.backgroundColor = .black
        tableBackgroundView.layer.cornerRadius = 13
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.tintColor = .white
        selectButton.setTitle("Select", for: .normal)
        selectButton.tintColor = UIColor(named: "yellowUIColor")
        titleLabel.text = "Select Option"
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor(named: "yellowUIColor")
        titleLabel.font =  UIFont(name: "SairaRoman-Regular", size: 16)
        optionsTableView.reloadData()
    }
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        coordinator?.back()
    }
    
    @IBAction func selectButtonPressed(_ sender: Any) {
        coordinator?.back()
        self.delegate?.didUpdateOperableArray(operableArray: operableArray)
    }
    
}
extension SelectOptionsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return operableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectOptionTableViewCell.cellID, for: indexPath) as! SelectOptionTableViewCell
        cell.setUp(parameter: operableArray[indexPath.row])
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        operableArray[indexPath.row].isChosen = !operableArray[indexPath.row].isChosen

        optionsTableView.reloadData()
        
    }
}
