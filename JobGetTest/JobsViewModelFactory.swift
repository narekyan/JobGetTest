//
//  JobsViewModelFactory.swift
//  JobGetTest
//
//  Created by Narek on 3/4/20.
//  Copyright © 2020 nb. All rights reserved.
//

import UIKit

class JobsViewModelFactory {
    
    static func getJobsViewModel<T: JobsSourceInterface>(jobsSourceType: T.Type) -> JobsViewModelInterface {
        return JobsViewModel(jobsSource: JobsSourceFactory.createJobsSource(jobsSourceType: jobsSourceType))
    }
}
