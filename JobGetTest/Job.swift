//
//  Job.swift
//  JobGetTest
//
//  Created by Narek on 3/3/20.
//  Copyright © 2020 nb. All rights reserved.
//

import UIKit

protocol Job: Decodable {
    
    var postedTimeFriendly: String { get set }
    var salary: Int { get set }
    var hiringCompany: String { get set }
    var url: String { get set }
    var snippet: String { get set }
    var name: String { get set }
    var location: String { get set }
    
}
