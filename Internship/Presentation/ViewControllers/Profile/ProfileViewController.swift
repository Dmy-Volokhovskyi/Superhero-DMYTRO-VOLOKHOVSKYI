//
//  ProfileViewController.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 22/02/2022.
//

import UIKit
import CoreData
class ProfileViewController: BaseViewViewController {
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var addOptionsButton: UIButton!
    
    var chosenParametersArray = [BodyParameterModel]()
    var parameterArray : [BodyParameterModel] = [] {
        didSet{
            chosenParametersArray = []
            for parameter in parameterArray {
                if parameter.isChosen == true {
                    chosenParametersArray.append(parameter)
                  print(  " shozen \(chosenParametersArray.count)")
                }
            }
            dataHasChanged = profileViewModel.checkIfDifferent(newArray: parameterArray)
            print(parameterArray.count)
            updateButtonState()
            menuTableView.reloadData()
        }
    }
    weak var coordinator : MainCoordinator?
    let profileViewModel = ProfileViewModel()
    var nameToSave : String!
    private var savedButton: UIBarButtonItem?
    var nameHasChanged = false
    var dataHasChanged = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        savedButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(savedButtonPressed))
        
        parameterArray = ProfileManager.sharedInstance.operableArray
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isOpaque = true
        
        menuTableView.register(UINib(nibName: MainMenuHeader.reuseID, bundle: nil), forHeaderFooterViewReuseIdentifier: MainMenuHeader.reuseID)
        menuTableView.register(UINib(nibName: MainMenuFooter.reuseID, bundle: nil), forHeaderFooterViewReuseIdentifier: MainMenuFooter.reuseID)
        menuTableView!.register(UINib.init(nibName: SettingsTableViewCell.cellID, bundle: nil), forCellReuseIdentifier: SettingsTableViewCell.cellID)
        menuTableView.backgroundColor = UIColor.clear
        
        menuTableView.dataSource = self
        menuTableView.delegate = self
        
        setUpInterface()
    }

    func setUpInterface (){
        //Set back image
        addImage(profileViewModel.getbackgroundImage())
        //Set button
        addOptionsButton.setTitle(profileViewModel.addOptionsButtonText, for: .normal)
        addOptionsButton.tintColor = .black
        addOptionsButton.backgroundColor = UIColor(named: "yellowUIColor")
        addOptionsButton.layer.cornerRadius = 25
        addOptionsButton.titleLabel?.font = UIFont(name: "SairaRoman-Regular", size: 16)
        // Add SavedButton and Title
        self.navigationItem.rightBarButtonItem  = savedButton
        self.title = profileViewModel.barButtonTitle
    }
    
    @objc  func savedButtonPressed (){
        //Save into CoreData
        profileViewModel.saveOptionsArray(parameters: parameterArray, and: nameToSave)
        parameterArray = profileViewModel.getData()
        savedButton?.isEnabled = false
    }
    
    @IBAction func addOptionsButtonpressed(_ sender: UIButton) {
        
        coordinator?.showOptions(model: profileViewModel, with: self, and: parameterArray)
    }
    
    func updateButtonState() {
        if nameHasChanged || dataHasChanged {
            savedButton?.isEnabled = true
        }else {
            savedButton?.isEnabled = false
        }
    }
    
}
//MARK: - TableViewDelegate Methods
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chosenParametersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.cellID, for: indexPath) as! SettingsTableViewCell
        cell.delegate = self
        cell.setCell(parameter: parameterArray, and: indexPath.row)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: MainMenuHeader.reuseID) as! MainMenuHeader
        //Set Header Look
        headerView.setupHeader(profileViewModel)
        //State this View  to be a delegate
        headerView.delegate = self
        //CheckForState In  Whe the header Loads Up
        headerView.checkForState()
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 270
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: MainMenuFooter.reuseID) as! MainMenuFooter
        // No need to send whole model, only 1 line is needed
        footerView.setUpFooter(with: profileViewModel.instructionText)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            self.chosenParametersArray.remove(at: indexPath.row)
            menuTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

}
//MARK: - MainMenuDelegateMethod
extension ProfileViewController : MainMenuHeaderDelegate {
    func presentImagePicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    func gotData(_ mainMenuHeader: MainMenuHeader, _ value: String, _ buttonState: Bool) {
        nameHasChanged = buttonState
        updateButtonState()
        nameToSave = value
    }
}

extension ProfileViewController : SelectOptionViewControllerDelegate {
    func didUpdateOperableArray(operableArray: [BodyParameterModel]) {
        parameterArray = operableArray
    }
}
extension ProfileViewController : SettingsTableViewCellDelegate {
    func checkNumbers(with operableArray: [BodyParameterModel]) {
        
        dataHasChanged = profileViewModel.checkIfDifferent(newArray: operableArray)
        updateButtonState()
    }
    
    func didChangeValue(with operableArray: [BodyParameterModel]) {
        self.parameterArray = operableArray
        print(parameterArray.count)
    }
}
extension ProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
