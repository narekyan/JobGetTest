//
//  JobsResponse.swift
//  JobGetTest
//
//  Created by Narek on 3/3/20.
//  Copyright © 2020 nb. All rights reserved.
//

import UIKit

struct ZipRecruiterJobsResponse: Decodable {
    var jobs: [ZipRecruiterJob]
}
