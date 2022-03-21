//
//  ProfileViewController.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 22/02/2022.
//

import UIKit

class ProfileViewController: BaseViewViewController {
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var addOptionsButton: UIButton!
    
    
    weak var coordinator : MainCoordinator?
    let profileViewModel = ProfileViewModel()
    var nameToSave : String!
    let savedButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(savedButtonPressed))
    var transition = AnimationManager(animationDuration: 1.0, animationType: .present)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        // SetNav bar
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isOpaque = true
        //Set tableView Header and Footer
        menuTableView.register(UINib(nibName: MainMenuHeader.reuseID, bundle: nil), forHeaderFooterViewReuseIdentifier: MainMenuHeader.reuseID)
        menuTableView.register(UINib(nibName: MainMenuFooter.reuseID, bundle: nil), forHeaderFooterViewReuseIdentifier: MainMenuFooter.reuseID)
        menuTableView!.register(UINib.init(nibName: SettingsTableViewCell.cellID, bundle: nil), forCellReuseIdentifier: SettingsTableViewCell.cellID)
        menuTableView.backgroundColor = UIColor.clear
        // Set Delegate Methods
        menuTableView.dataSource = self
        menuTableView.delegate = self
        //Set Interface
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
        ProfileManager.sharedInstance.saveProfileWith(with: profileViewModel.profile!.sex ?? " " , with: nameToSave)
        savedButton.isEnabled = false
    }
    
    @IBAction func addOptionsButtonpressed(_ sender: UIButton) {
        print("Saved")
        let detailVC = ProfileViewController.instantiate()
        navigationController?.modalPresentationStyle = .custom
        navigationController?.pushViewController(detailVC, animated: true)

//        coordinator?.showOptions()
    }
    
}
//MARK: - TableViewDelegate Methods
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        cell.setCell()
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
        return 300
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
}
//MARK: - MainMenuDelegateMethod
extension ProfileViewController : MainMenuHeaderDelegate {
    func gotData(_ mainMenuHeader: MainMenuHeader, _ value: String, _ buttonState: Bool) {
        savedButton.isEnabled = buttonState
        nameToSave = value
    }
}

extension ProfileViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return AnimationManager(animationDuration: 4, animationType: .present)
        case .pop:
            return AnimationManager(animationDuration: 1.3, animationType: .dismiss)
        default:
            return nil
        }
    }
}
