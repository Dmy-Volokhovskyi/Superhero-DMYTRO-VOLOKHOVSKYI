//
//  ProfileViewController.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 22/02/2022.
//

import UIKit

class ProfileViewController: UIViewController,Storyboarded {
    
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var addOptionsButton: UIButton!
    
    
    weak var coordinator : MainCoordinator?
    let profileViewModel = ProfileViewModel()
    var nameToSave : String!
    let savedButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(savedButtonPressed))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isOpaque = true
        
        menuTableView.register(UINib(nibName: "MainMenuHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "MainMenuHeader")
        menuTableView.register(UINib(nibName: "MainMenuFooter", bundle: nil), forHeaderFooterViewReuseIdentifier: "MainMenuFooter")
        menuTableView!.register(UINib.init(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsTableViewCell")
        
        menuTableView.backgroundColor = UIColor.clear
        menuTableView.dataSource = self
        menuTableView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(UITextField.textDidChangeNotification.rawValue), object: nil)
        setUpInterface()
    }
    func setUpInterface (){
        //Set back image
        backgroundImage.image = profileViewModel.getbackgroundImage()
        //Set button
        addOptionsButton.setTitle(profileViewModel.addOptionsButtonText, for: .normal)
        addOptionsButton.tintColor = .black
        addOptionsButton.backgroundColor = UIColor(named: "yellowUIColor")
        addOptionsButton.layer.cornerRadius = 25
        addOptionsButton.titleLabel?.font = UIFont(name: "SairaRoman-Regular", size: 16)
        // Add SavedButton and Title
        self.navigationItem.rightBarButtonItem  = savedButton
        self.title = profileViewModel.barButtonTitle
        // add gradient to a view
        backgroundImage.addGradient(colors: [.black, UIColor.clear], locations: [0.27,1], startPoint: CGPoint(x: 0.0, y: 1.0), endPoint: CGPoint(x: 0.0, y: 0.0), type: .axial, frame: backgroundImage.frame)
        
    }
    @objc  func savedButtonPressed (){
        ProfileManager.sharedInstance.saveProfileWith(with: profileViewModel.profile!.sex ?? " " , with: nameToSave)
        savedButton.isEnabled = false
    }
    @IBAction func addOptionsPressed(_ sender: UIButton) {
        for fontFamilyName in UIFont.familyNames{
            for fontName in UIFont.fontNames(forFamilyName: fontFamilyName){
                print("Family: \(fontFamilyName)     Font: \(fontName)")
            }
        }
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        cell.setCell()
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MainMenuHeader") as! MainMenuHeader
        let backgroundView = UIView(frame: headerView.bounds)
        backgroundView.backgroundColor = UIColor.clear
        headerView.backgroundView = backgroundView
        headerView.setupHeader()
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MainMenuFooter") as! MainMenuFooter
        footerView.setUpFooter(with: profileViewModel.instructionText)
        let backgroundView = UIView(frame: footerView.bounds)
        backgroundView.backgroundColor = UIColor.clear
        footerView.backgroundView = backgroundView
        return footerView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 120
    }


    @objc func methodOfReceivedNotification(notification: Notification) {
        let header = menuTableView.headerView as! MainMenuHeader
        if let textField = notification.object as? UITextField {
            if let text = textField.text {
                if text == profileViewModel.profile?.name || text == "" {
                    nameToSave = text
                    savedButton.isEnabled = false
//                    header.lineVIew.backgroundColor = .orange
                    print("Hello Good")
                }else {
                    savedButton.isEnabled = true
//                    header.backgroundColor = .white
                    print("DontMatch")
                    nameToSave = text
                }
            }
        }
    }
}
