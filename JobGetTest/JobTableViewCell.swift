//
//  JobTableViewCell.swift
//  JobGetTest
//
//  Created by Narek on 3/3/20.
//  Copyright © 2020 nb. All rights reserved.
//

import UIKit

class JobTableViewCell: UITableViewCell {

    static var identifier: String {
        return String(describing: JobTableViewCell.classForCoder())
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var snippetLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var sallaryLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
        
    var job: Job? {
        didSet {
            nameLabel.text = job?.name
            snippetLabel.text = job?.snippet.trimmingCharacters(in: .whitespacesAndNewlines)
            locationLabel.text = job?.location
            companyLabel.text = job?.hiringCompany
            timeLabel.text = job?.postedTimeFriendly
            sallaryLabel.text = ""
            if let sallary = job?.salary, sallary > 0 {
                sallaryLabel.text = " \(sallary)"
            }
        }
    }
    
}
