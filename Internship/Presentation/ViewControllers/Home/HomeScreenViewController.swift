//
//  HomeScreenVC.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 20/02/2022.
//

import Foundation
import UIKit

class HomeScreenViewController : BaseViewViewController, UICollectionViewDataSource{

    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var menuTable: UITableView!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var parametersCollectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!
    //    @IBOutlet weak var backgroundImage: UIImageView!
    
    weak var coordinator : MainCoordinator?
    var homeScreenModel = HomeScreenModel()
    var toggleArray : [BodyParameterModel] = [] {
        didSet{
            parametersCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableview delegates
        menuTable.dataSource = self
        menuTable.delegate = self
        parametersCollectionView.delegate = self
        parametersCollectionView.dataSource = self
        //regiseter cell
        menuTable!.register(UINib.init(nibName: MenuCell.cellID, bundle: nil), forCellReuseIdentifier: MenuCell.cellID)
        parametersCollectionView.register(UINib(nibName:ParametersCollectionViewCell.cellID, bundle: nil), forCellWithReuseIdentifier:ParametersCollectionViewCell.cellID)
        setInterface()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        ProfileManager.sharedInstance.loadBodyParameters()
        scrollView.setContentOffset(.zero, animated: true)
        navigationController?.navigationBar.isHidden = true
        nameLabel.text = ProfileManager.sharedInstance.userProfile?.name ?? ""
        toggleArray = homeScreenModel.formToggledArray()
    }
    
    
    private func setInterface() {
        // Get information for correct image and text
        let gender = homeScreenModel.gender
        // set correct image and text
        if gender == "SUPERGIRL"{
            addImage(homeScreenModel.girlImage)
            genderLabel.text = homeScreenModel.girlTitle
        }else {
            addImage(homeScreenModel.manlImage)
            genderLabel.text = homeScreenModel.manTitle
        }
        
        toggleArray = homeScreenModel.formToggledArray()
        parametersCollectionView.reloadData()
        parametersCollectionView.backgroundColor = .clear
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
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.cellID, for: indexPath) as! MenuCell
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
extension HomeScreenViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(toggleArray.count)
        return toggleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ParametersCollectionViewCell.cellID, for: indexPath) as! ParametersCollectionViewCell
        cell.setUpCell(with: toggleArray[indexPath.item])
        return cell
    }
}
extension HomeScreenViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 84)
    }
}
