//
//  Job.swift
//  JobGetTest
//
//  Created by Narek on 3/3/20.
//  Copyright © 2020 nb. All rights reserved.
//

import UIKit

struct ZipRecruiterJob: Job {
    
    private enum CodingKeys : String, CodingKey {
        case postedTimeFriendly = "posted_time_friendly",
        salary = "salary_max_annual",
        hiringCompany = "hiring_company",
        url,
        snippet,
        name,
        location
    }
 
    var postedTimeFriendly: String = ""
    var salary: Int = 0
    var hiringCompany: String = "" // name
    var url: String = ""
    var snippet: String = ""
    var name: String = ""
    var location: String = ""
    
    init(from: Decoder) {
        do {
            let container = try from.container(keyedBy: CodingKeys.self)
            postedTimeFriendly = try container.decode(String.self, forKey: .postedTimeFriendly)
            salary = try container.decode(Int.self, forKey: .salary)
            url = try container.decode(String.self, forKey: .url)
            snippet = try container.decode(String.self, forKey: .snippet)
            name = try container.decode(String.self, forKey: .name)
            location = try container.decode(String.self, forKey: .location)
            let companyContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .hiringCompany)
            hiringCompany = try companyContainer.decode(String.self, forKey: .name)
        } catch {
            print(error.localizedDescription)
        }
    }
}
