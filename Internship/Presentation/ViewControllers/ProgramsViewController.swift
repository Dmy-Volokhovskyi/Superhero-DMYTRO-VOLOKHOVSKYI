//
//  ProgramsViewController.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 22/02/2022.
//

import UIKit

class ProgramsViewController: UIViewController,Storyboarded {

    weak var coordinator : MainCoordinator?
    let programsViewModel = ProgramsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = programsViewModel.barButtonTitle
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
