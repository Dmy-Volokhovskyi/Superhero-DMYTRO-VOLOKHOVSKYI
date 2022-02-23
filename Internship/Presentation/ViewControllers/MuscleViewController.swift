//
//  MuscleViewController.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 22/02/2022.
//

import UIKit

class MuscleViewController: UIViewController,Storyboarded {

    weak var coordinator : MainCoordinator?
    let muscleViewModel = MuscleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = muscleViewModel.barButtonTitle
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
