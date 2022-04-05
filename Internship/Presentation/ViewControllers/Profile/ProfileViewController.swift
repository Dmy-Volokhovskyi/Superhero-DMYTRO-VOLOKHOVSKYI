//
//  ProfileViewController.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 22/02/2022.
//

import UIKit
import CoreData

class ProfileViewController: BaseViewViewController, Storyboarded {
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var addOptionsButton: UIButton!
    
    weak var coordinator : MainCoordinator?
    private var profileViewModel  = ProfileViewModel()
    private var savedButton: UIBarButtonItem?
    private var headerView : MainMenuHeader?
    private let transition = PanelTransition()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        savedButton = UIBarButtonItem(title: profileViewModel.saveButtonTitle, style: .plain, target: self, action: #selector(savedButtonPressed))
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isOpaque = true
        
        menuTableView.register(UINib(nibName: MainMenuHeader.reuseID, bundle: nil), forHeaderFooterViewReuseIdentifier: MainMenuHeader.reuseID)
        menuTableView.register(UINib(nibName: MainMenuFooter.reuseID, bundle: nil), forHeaderFooterViewReuseIdentifier: MainMenuFooter.reuseID)
        menuTableView!.register(UINib.init(nibName: SettingsTableViewCell.cellID, bundle: nil), forCellReuseIdentifier: SettingsTableViewCell.cellID)
        menuTableView.backgroundColor = UIColor.clear
        
        menuTableView.dataSource = self
        menuTableView.delegate = self
        menuTableView.keyboardDismissMode = .onDrag
        
        setUpInterface()
    }
    
    func setUpInterface (){
        //Set back image
        addImage(profileViewModel.getbackgroundImage())
        //Set button
        addOptionsButton.setTitle(profileViewModel.addOptionsButtonText, for: .normal)
        addOptionsButton.tintColor = .black
        addOptionsButton.backgroundColor = UIColor.getCustomOrangeColor()
        addOptionsButton.layer.cornerRadius = 25
        addOptionsButton.titleLabel?.font = UIFont.getCustomFont(.SairaRomanRegular, 16)
        // Add SavedButton and Title 
        self.navigationItem.rightBarButtonItem  = savedButton
        self.title = profileViewModel.barButtonTitle
    }
    
    @objc  func savedButtonPressed (){
        //Save into CoreData
        if profileViewModel.checkForZeroValues(withAn: profileViewModel.selectedParametersArray){
            presentNonSavedAllert()
        }else{
            profileViewModel.saveOptionsArray(parameters: profileViewModel.selectedParametersArray, and: profileViewModel.nameToSave, and: profileViewModel.profileImage)
            coordinator?.back()
        }
    }
    
    @IBAction func addOptionsButtonpressed(_ sender: UIButton) {
        let child = SelectOptionsViewController.instantiate()
        child.delegate = self
        child.transitioningDelegate = transition
        child.modalPresentationStyle = .custom
        child.viewModel = profileViewModel
        present(child, animated: true)
    }
    
    
    func presentNonSavedAllert() {
        let alert = UIAlertController(title: profileViewModel.zeroValueMasage, message: profileViewModel.chooseAdviceMassage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: profileViewModel.confirmationMassage, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
//MARK: - TableViewDelegate Methods
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileViewModel.selectedParametersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.cellID, for: indexPath) as! SettingsTableViewCell
        cell.delegate = self
        cell.setCell(parameter: profileViewModel.selectedParametersArray, and: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: MainMenuHeader.reuseID) as? MainMenuHeader
        
        headerView?.setupHeader(profileViewModel)
        headerView?.delegate = self
        headerView?.checkForState()
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 321
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: MainMenuFooter.reuseID) as! MainMenuFooter
        footerView.setUpFooter(with: profileViewModel.instructionText)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            profileViewModel.deleteItem(with: profileViewModel.selectedParametersArray[indexPath.row])
            profileViewModel.selectedParametersArray.remove(at: indexPath.row)
            savedButton?.isEnabled = profileViewModel.updateButtonState()
            tableView.reloadSections([0], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
}
//MARK: - MainMenuHeaderDelegateMethod
extension ProfileViewController : MainMenuHeaderDelegate {
    
    func presentImagePicker() {
        presentActionSheet ()
    }
    
    func gotData(_ mainMenuHeader: MainMenuHeader, _ value: String, _ buttonState: Bool) {
        profileViewModel.nameHasChanged = buttonState
        savedButton?.isEnabled = profileViewModel.updateButtonState()
        profileViewModel.nameToSave = value
    }
}
//MARK: - SelectOptionDelegate
extension ProfileViewController : SelectOptionViewControllerDelegate {
    
    func didUpdateOperableArray(operableArray: [BodyParameterModel]) {
        profileViewModel.reloadData()
        menuTableView.reloadData()
    }
}

// MARK: - TableCellDelegate
extension ProfileViewController : SettingsTableViewCellDelegate {
    func checkNumbers(with localIndex: Int, and value: Int32, _ values: [Int32], _ dates: [Date]) {
        profileViewModel.selectedParametersArray[localIndex].measureValue = value
        profileViewModel.selectedParametersArray[localIndex].dates = dates
        profileViewModel.selectedParametersArray[localIndex].values = values
        profileViewModel.dataHasChanged = profileViewModel.checkIfDifferent()
        savedButton?.isEnabled = profileViewModel.updateButtonState()
    }
    
    
    func keyboardIsShown(sender: NSNotification) {
        if ((sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRectangle.height
                
                let contentInset:UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20 + keyboardHeight, right: 0)
                self.menuTableView.contentInset = contentInset
            }
        }
    }
    
    func keyboardIsHidden(sender: NSNotification) {
        
        if ((sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            let contentInset:UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.menuTableView.contentInset = contentInset
        }
    }
    
    func didChangeValue(with localIndex: Int, and value: Bool) {
        
        profileViewModel.selectedParametersArray[localIndex].isToggled = value
        profileViewModel.dataHasChanged = profileViewModel.checkIfDifferent()
        savedButton?.isEnabled = profileViewModel.updateButtonState()
        
    }
}

//MARK: - Image picker Delegate
extension ProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileViewModel.profileImage.contentMode = .scaleAspectFit
            profileViewModel.profileImage.image = pickedImage
            headerView?.setImage(with: profileViewModel.profileImage)
            profileViewModel.didChangeImage = true
            savedButton?.isEnabled = profileViewModel.updateButtonState()
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func presentActionSheet () {
        let alert = UIAlertController(title: profileViewModel.choseImageMassage, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: profileViewModel.cameraOption, style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: profileViewModel.galeryOption, style: .default, handler: { _ in
            self.openGallery()
        }))
        
        if profileViewModel.profileImage.image != nil {
            alert.addAction(UIAlertAction(title: profileViewModel.deleteButtonText, style: .destructive, handler: { _ in
                self.profileViewModel.profileImage.image = nil
                self.headerView?.setImage(with: self.profileViewModel.profileImage)
            }))
        }
        
        alert.addAction(UIAlertAction.init(title: profileViewModel.cancelButtonText, style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: profileViewModel.warningMassage, message: profileViewModel.noCameraAcessMassage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: profileViewModel.confirmationMassage, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery(){
        
        if
            UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: profileViewModel.warningMassage, message: profileViewModel.noGalleryAcessmassage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: profileViewModel.confirmationMassage, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

