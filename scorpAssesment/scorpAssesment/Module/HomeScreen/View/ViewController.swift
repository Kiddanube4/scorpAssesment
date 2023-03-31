//
//  ViewController.swift
//  scorpAssesment
//
//  Created by Namik Karabiyik on 30.03.2023.
//

import UIKit

class ViewController: UIViewController {
 
    
    lazy var homeviewModel: HomeScreenViewModel = {
        var homeViewModelData = HomeScreenViewModel()
        homeViewModelData.homeVMDelegate = self
        return homeViewModelData
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        homeviewModel.fetchData(next: nil)
        print("viewcontroller")
    }
}

extension ViewController:HomeScreenViewModelDelegate {
    func fetch(_ didFail: FetchError) {
        
    }
    
    func fetch(_ didSucceed: [Person]) {
        for person in didSucceed {
            print(person.fullName,person.id)
        }
    }
}

