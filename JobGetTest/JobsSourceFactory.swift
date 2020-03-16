//
//  JobsSourceFactory.swift
//  JobGetTest
//
//  Created by Narek on 3/4/20.
//  Copyright © 2020 nb. All rights reserved.
//

import UIKit

class JobsSourceFactory {
    
    static func createJobsSource<T: JobsSourceInterface>(jobsSourceType: T.Type) -> T {
        return jobsSourceType.init()
    }
    
    static func getZipRecruiterJobsSource() -> JobsSourceInterface {
        return ZipRecruiterJobsSource()
    }
}
