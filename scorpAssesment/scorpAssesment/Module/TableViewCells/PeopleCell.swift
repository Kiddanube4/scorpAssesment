//
//  PeopleCell.swift
//  scorpAssesment
//
//  Created by Namik Karabiyik on 31.03.2023.
//

import Foundation
import UIKit

class PeopleCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblId: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var viewModelData: Person? {
        didSet {
            print("current vm data : \(viewModelData)")
            if let person = viewModelData {
                lblId.text = String(person.id)
                lblName.text = person.fullName
                
            }else {
                lblName.text = "Not found"
                lblId.text = "0"
            }
        }
    }
    
    var cellErrorModel: FetchError? {
        didSet {
            if let error = cellErrorModel {
                lblName.text = error.errorDescription
                lblId.isHidden = true
            }
        }
    }
}
