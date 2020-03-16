//
//  JobsNetworkLayer.swift
//  JobGetTest
//
//  Created by Narek on 3/3/20.
//  Copyright © 2020 nb. All rights reserved.
//

import UIKit

class ZipRecruiterJobsSource: JobsSourceInterface {
    
    static let baseUrl = "https://api.ziprecruiter.com/jobs/v1?"
    static let jobsPerPage = "20"
    static let apiKey = "mthpyw9ea7zyswfuj3zur6bt55fce7qf"
    
    required init() {
    }
    
    func searchJobs(title: String, location: String, page: Int, completion: @escaping ([Job]?, _ errorMessage: String?) -> Void) {
        
        let params = ["search": title,
                      "location": location,
                      "radius_miles": "",
                      "days_ago": "",
                      "jobs_per_page": ZipRecruiterJobsSource.jobsPerPage,
                      "page": "\(page)",
                      "api_key": ZipRecruiterJobsSource.apiKey
        ]
        
        let url = ZipRecruiterJobsSource.baseUrl + generateQuery(params)
        NetworkManager().get(urlString: url) { (result: ZipRecruiterJobsResponse?, errorMessage: String?) in
            DispatchQueue.main.async {
                completion(result?.jobs, errorMessage)
            }
        }
    }
    
    private func generateQuery(_ params:[String: String]) -> String {
        var result = ""
        for param in params {
            result += param.key+"="+(param.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")+"&"
        }
        return result
    }
}
