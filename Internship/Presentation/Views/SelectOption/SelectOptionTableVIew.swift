//
//  SelectOptionTableVIew.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 19/03/2022.
//

import UIKit

class SelectOptionTableVIew: UITableView {
    
    var bodyParameterStorage = BodyParameterStorage()
    var array = [BodyParameter]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    func setupTableView() {
        array = bodyParameterStorage.getBodyParameters()
        self.dataSource = self
        self.delegate = self
        self.bounces = false
        self.insetsLayoutMarginsFromSafeArea = false
        self.register(UINib(nibName: SelectOptionFooter.footerID, bundle: nil), forHeaderFooterViewReuseIdentifier: SelectOptionFooter.footerID)
        self.register(UINib(nibName: SelectOptionHeader.headerID, bundle: nil), forHeaderFooterViewReuseIdentifier: SelectOptionHeader.headerID)
        self.register(UINib.init(nibName: SelectOptionTableViewCell.cellID, bundle: nil), forCellReuseIdentifier: SelectOptionTableViewCell.cellID)
        self.layer.borderWidth = 1
        self.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        self.backgroundColor = .black
        
        self.reloadData()
    }
}
extension SelectOptionTableVIew :UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectOptionTableViewCell.cellID, for: indexPath) as! SelectOptionTableViewCell
        cell.setUp(parameter: array[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SelectOptionHeader.headerID) as! SelectOptionHeader
        headerView.setUp()
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SelectOptionFooter.footerID) as! SelectOptionFooter
        // No need to send whole model, only 1 line is needed
        
        footerView.setFooter()
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
