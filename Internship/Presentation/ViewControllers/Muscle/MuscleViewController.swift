//
//  MuscleViewController.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 22/02/2022.
//

import UIKit

class MuscleViewController: BaseViewViewController,Storyboarded {
    
    @IBOutlet weak var exerciseTableView: UITableView!
    weak var coordinator : MainCoordinator?
    let muscleViewModel = MuscleViewModel()
    var headerView : ExerciseMenuHeader?
    var changesMode : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exerciseTableView.register(UINib.init(nibName: ExerciseTableViewCell.cellID, bundle: nil), forCellReuseIdentifier: ExerciseTableViewCell.cellID)
        setUP()
        exerciseTableView.delegate = self
        exerciseTableView.dataSource = self
        exerciseTableView.register(UINib(nibName: ExerciseMenuHeader.reuseID, bundle: nil), forHeaderFooterViewReuseIdentifier: ExerciseMenuHeader.reuseID)
        addImage(muscleViewModel.getbackgroundImage())
        
        
    }
}
extension MuscleViewController :UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return muscleViewModel.muscleSectionViewModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return muscleViewModel.muscleSectionViewModels[section].exercises?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseTableViewCell.cellID, for: indexPath) as? ExerciseTableViewCell
        
        cell?.setUp(with:(muscleViewModel.muscleSectionViewModels[indexPath.section].exercises?[indexPath.row])! )
        cell?.changeIsSelected = { [weak self] in
            self!.muscleViewModel.changeTrueToFalse(indexPath.section, indexPath.row)
            self!.muscleViewModel.fillExerciseData(wiht: indexPath.section, and: self!.muscleViewModel.muscleSectionViewModels[indexPath.section].rollState)
            self!.exerciseTableView.reloadSections(IndexSet(indexPath), with: .automatic)
            
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ExerciseMenuHeader.reuseID) as? ExerciseMenuHeader
        headerView?.tapClosure = { [weak self] in
            self!.muscleViewModel.fillExerciseData(wiht: section, and: self!.muscleViewModel.muscleSectionViewModels[section].rollState)
            self?.exerciseTableView.reloadData()
        }
        headerView?.setUP(muscleViewModel.muscleSectionViewModels[section])
        
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func setUP() {
        self.title = muscleViewModel.barButtonTitle
        self.navigationController?.navigationBar.isHidden = false
        
        exerciseTableView.backgroundColor = .clear
    }
    
}
