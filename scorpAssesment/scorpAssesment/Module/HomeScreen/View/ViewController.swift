//
//  ViewController.swift
//  scorpAssesment
//
//  Created by Namik Karabiyik on 30.03.2023.
//

import UIKit

class ViewController: UIViewController {
 
    
    @IBOutlet weak var tableViewPerson: UITableView!
    
    
    lazy var homeviewModel: HomeScreenViewModel = {
        var homeViewModelData = HomeScreenViewModel()
        homeViewModelData.homeVMDelegate = self
        return homeViewModelData
    }()
    
    var personData = [Person]()
    var uniquePerson = [Person]()
    var uniquePersonCount = 0
    let refreshControl = UIRefreshControl()
    var containerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        homeviewModel.fetchData(next: nil)
        homeviewModel.registerTableViewCells(name: "PeopleCell", tableview: tableViewPerson, reuseID: "PeopleCell")
        
    
        
        tableViewPerson.refreshControl = refreshControl
        
        tableViewPerson.dataSource = self
        tableViewPerson.delegate = self
        
        print("viewcontroller")
    }
    
    @objc func reloadData() {
        personData = []
        uniquePerson = []
        
        containerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.view.addSubview(containerView)
        
        VCUtils().showActivityIndicator(uiView: containerView)
        homeviewModel.fetchData(next: "10")
        
    }
}

extension ViewController:HomeScreenViewModelDelegate {
    func fetch(_ didFail: FetchError) {
        refreshControl.endRefreshing()
        tableViewPerson.reloadData()
        containerView.removeFromSuperview()
        switch didFail.errorDescription {
        case .parameterError:
            VCUtils.showAlertAction(title: "Hata !", message: "Hatalı bir parametre gitdiniz lütfen yeniden deneyin. ", viewController: self) {
                self.homeviewModel.fetchData(next: "10")
            }
            
        case .internalServerError:
            VCUtils.showAlertAction(title: "Hata !", message: "Sunucu hatası lütfen yeniden deneyin. ", viewController: self) {
                self.homeviewModel.fetchData(next: "10")
            }
        }
    }
    
    func fetch(_ didSucceed: [Person]) {
        if didSucceed.count != 0 {
            //handle data
            uniquePersonCount = uniquePerson.count
            for person in didSucceed {
                if !uniquePerson.contains(where: { $0.id == person.id }) {
                    uniquePerson.append(person)
                }
            }
            
            refreshControl.endRefreshing()
            tableViewPerson.reloadData()
            containerView.removeFromSuperview()
            
        }else {
            VCUtils.showAlertAction(title: "Hata !", message: "Sunucu hatası lütfen yeniden deneyin. ", viewController: self) {
                self.homeviewModel.fetchData(next: "10")
        }
       
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == uniquePerson.count - 1 && uniquePersonCount < uniquePerson.count  {
           containerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
            self.view.addSubview(containerView)
            VCUtils().showActivityIndicator(uiView: containerView)
            homeviewModel.fetchData(next: "10")
        }
       
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uniquePerson.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PeopleCell") as? PeopleCell {
            
             cell.viewModelData = homeviewModel.getCellData(at: indexPath, from: uniquePerson)
              return cell
          }
          
          return UITableViewCell()
    }
    
    
    
}

