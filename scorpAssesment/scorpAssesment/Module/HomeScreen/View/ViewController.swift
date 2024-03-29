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
            for person in didSucceed {
                personData.append(person)
            }
            personData = personData.unique(by: \.id)
            refreshControl.endRefreshing()
            tableViewPerson.reloadData()
            containerView.removeFromSuperview()
            return
        }
        VCUtils.showAlertAction(title: "Hata !", message: "Sunucu hatası lütfen yeniden deneyin. ", viewController: self) {
            self.homeviewModel.fetchData(next: "10")
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == personData.count - 1  {
           containerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
            self.view.addSubview(containerView)
            VCUtils().showActivityIndicator(uiView: containerView)
            homeviewModel.fetchData(next: "10")
        }
       
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PeopleCell") as? PeopleCell {
            
             cell.viewModelData = homeviewModel.getCellData(at: indexPath, from: personData)
              return cell
          }
          
          return UITableViewCell()
    }
    
    
    
}

