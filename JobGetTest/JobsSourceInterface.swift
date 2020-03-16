//
//  JobsNetworkLayer.swift
//  JobGetTest
//
//  Created by Narek on 3/3/20.
//  Copyright © 2020 nb. All rights reserved.
//

import UIKit

protocol JobsSourceInterface {
    init()
    
    func searchJobs(title: String, location: String, page: Int, completion: @escaping ([Job]?, _ errorMessage: String?) -> Void)
}
