//
//  HomeScreenVC.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 20/02/2022.
//

import Foundation
import UIKit

class HomeScreenViewController : UIViewController,Storyboarded{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var menuTable: UITableView!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    weak var coordinator : MainCoordinator?
    let homeScreenModel = HomeScreenModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableview delegates
        menuTable.dataSource = self
        menuTable.delegate = self
        //regiseter cell
        menuTable!.register(UINib.init(nibName: homeScreenModel.cellNibName, bundle: nil), forCellReuseIdentifier: homeScreenModel.reuseIdentifier)
        setInterface()
    }
    override func viewDidAppear(_ animated: Bool) {

       scrollView.setContentOffset(.zero, animated: true)
       navigationController?.navigationBar.isHidden = true
        nameLabel.text = ProfileManager.sharedInstance.userProfile?.name ?? ""
    }

    
    private func setInterface() {
        // Get information for correct image and text
        let gender = homeScreenModel.gender
        // set correct image and text
        if gender == "SUPERGIRL"{
            backgroundImage.image = homeScreenModel.girlImage
            genderLabel.text = homeScreenModel.girlTitle
        }else {
            backgroundImage.image = homeScreenModel.manlImage
            genderLabel.text = homeScreenModel.manTitle
        }
        // features used on image that dont rely on image itself
        backgroundImage.contentMode = .scaleToFill
        backgroundImage.addGradient(colors: [.black, UIColor.clear], locations: [0.27,1], startPoint: CGPoint(x: 0.0, y: 1.0), endPoint: CGPoint(x: 0.0, y: 0.0), type: .axial, frame: backgroundImage.frame)
        // Top label Set up
        genderLabel.textColor = .white
        genderLabel.font = UIFont(name: "SairaRoman-Regular", size: 24)
        // menu setup
        menuTable.backgroundColor = UIColor.clear
        menuTable.alwaysBounceVertical = false
        nameLabel.text = homeScreenModel.name
        nameLabel.textColor = UIColor(named: "yellowUIColor")
        nameLabel.font = UIFont(name: "HelveticaNeue", size: 20.0)
    }
}

extension HomeScreenViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return homeScreenModel.menuArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: homeScreenModel.reuseIdentifier, for: indexPath) as! MenuCell
        cell.setUpCell(with: homeScreenModel.menuArray[indexPath.section])
        return cell
    }
}

extension HomeScreenViewController : UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 4
    }
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        scrollView.setContentOffset(.zero, animated: false)
        homeScreenModel.categorySelected(with: indexPath.section, coordinator: coordinator!)
    }
}

