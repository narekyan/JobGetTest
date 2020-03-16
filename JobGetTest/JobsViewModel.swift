//
//  JobsViewModel.swift
//  JobGetTest
//
//  Created by Narek on 3/3/20.
//  Copyright © 2020 nb. All rights reserved.
//

import UIKit

protocol JobsViewModelDelegate: class {
    func viewModelDidFetchJobs(_ viewModel: JobsViewModel)
    func viewModel(_ viewModel: JobsViewModel, didFailWithErrorMessage errorMessage: String)
}

protocol JobsViewModelInterface {
    var delegate: JobsViewModelDelegate? { get set }
    var title: String {get}
    var location: String {get}
    
    func numberOfJobs() -> Int
    func job(atIndex index: Int) -> Job
    func fetch(title: String, location: String);
    func fetchNextPage() -> Bool;
}

class JobsViewModel: JobsViewModelInterface {
    
    fileprivate var jobsSource: JobsSourceInterface?
    fileprivate var jobs = [Job]()
    fileprivate var page = 0
    
    var delegate: JobsViewModelDelegate?
    var title: String = ""
    var location: String  = ""
    
    init(jobsSource: JobsSourceInterface) {
        self.jobsSource = jobsSource
    }
    
    func numberOfJobs() -> Int {
        return jobs.count
    }
    
    func job(atIndex index: Int) -> Job {
        return jobs[index]
    }
    
    func fetch(title: String, location: String) {
        page = 0
        jobs.removeAll()
        self.title = title
        self.location = location
        _ = fetchNextPage()
    }
    
    func fetchNextPage() -> Bool {
        if page == -1 {
            return false
        }
        self.page += 1
        jobsSource?.searchJobs(title: title, location: location, page: page, completion: { (jobs: [Job]?, errorMessage: String?) in
            guard let jobs = jobs else {
                let errorMessage = errorMessage ?? "Something went wrong"
                self.delegate?.viewModel(self, didFailWithErrorMessage: errorMessage)
                return
            }
            if jobs.count == 0 {
                self.page = -1
            } else {
                self.jobs.append(contentsOf: jobs)
            }
            self.delegate?.viewModelDidFetchJobs(self)
        })
        return true
    }
}
