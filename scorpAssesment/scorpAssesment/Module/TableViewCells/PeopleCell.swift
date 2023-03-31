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
            if let person = viewModelData {
                lblId.text = String(person.id)
                lblName.text = person.fullName
                
            }else {
                lblName.text = "Not found"
                lblId.text = "0"
            }
        }
    }
}
