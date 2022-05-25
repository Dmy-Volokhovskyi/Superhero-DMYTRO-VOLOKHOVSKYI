//
//  ProgressViewController.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 22/02/2022.
//

import UIKit

class ProgressViewController: BaseViewViewController,Storyboarded {

    @IBOutlet weak var menuTableView: UITableView!
    weak var coordinator : MainCoordinator?
    let progressViewModel = ProgressViewModel()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.register(UINib.init(nibName: MenuCell.cellID, bundle: nil), forCellReuseIdentifier: MenuCell.cellID)
        
      setUp()

    }
    func setUp() {
        self.title = progressViewModel.barButtonTitle
        self.navigationController?.navigationBar.isHidden = false
        addImage(progressViewModel.getbackgroundImage())
        menuTableView.backgroundColor = .clear
    }

    
}
extension ProgressViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return progressViewModel.toggledArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.cellID, for: indexPath) as! MenuCell
        cell.setUpCell(with: progressViewModel.toggledArray[indexPath.row].parameterName ?? "Default")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        progressViewModel.formDataEntries(progressViewModel.toggledArray[indexPath.row])
        coordinator?.chart(progressViewModel.toggledArray[indexPath.row], progressViewModel)
    }
}
