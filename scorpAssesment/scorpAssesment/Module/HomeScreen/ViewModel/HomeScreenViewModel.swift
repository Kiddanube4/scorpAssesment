//
//  HomeScreenViewModel.swift
//  scorpAssesment
//
//  Created by Namik Karabiyik on 31.03.2023.
//

import Foundation

class HomeScreenViewModel {
    var homeVMDelegate: HomeScreenViewModelDelegate?
    var currentPage = 1
    var totalPages = 1
    
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
}




