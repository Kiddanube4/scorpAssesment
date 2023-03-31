//
//  HomeScreenViewModel.swift
//  scorpAssesment
//
//  Created by Namik Karabiyik on 31.03.2023.
//

import Foundation
import UIKit

class HomeScreenViewModel {
    var homeVMDelegate: HomeScreenViewModelDelegate?
    
     func fetchData(next:String?) {
         DataSource.fetch(next: next) {  response, error in
            if let error = error {
                // error handling must be done on view
                self.homeVMDelegate?.fetch(error)
        
            }else {
                guard let data = response else {return}
                self.homeVMDelegate?.fetch(data.people)
            }
        }
    }
    
    func registerTableViewCells(name:String, tableview: UITableView, reuseID: String) {
        let textFieldCell = UINib(nibName: name,
                                  bundle: nil)
        tableview.register(textFieldCell,
                                forCellReuseIdentifier: reuseID)
    }
    
     func getCellData<T>(at indexPath: IndexPath, from data: [T?]) -> T? {
        return data.isEmpty == true ? nil : data[indexPath.row]
    }

}




