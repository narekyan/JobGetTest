//
//  ViewController.swift
//  JobGetTest
//
//  Created by Narek on 3/3/20.
//  Copyright © 2020 nb. All rights reserved.
//

import UIKit

class JobsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var searchBarView: SearchBarView!
    
    var viewModel: JobsViewModelInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib.init(nibName: JobTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: "cell")
        
        initViewModel()
    }

    private func initViewModel() {
        viewModel = JobsViewModelFactory.getJobsViewModel(jobsSourceType: ZipRecruiterJobsSource.self)
        viewModel?.delegate = self
    }

}

extension JobsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfJobs() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? JobTableViewCell
        cell?.job = viewModel?.job(atIndex: indexPath.row)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let job = viewModel?.job(atIndex: indexPath.row), let url = URL(string: job.url)  {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !activityIndicatorView.isAnimating {
            if indexPath.row == (viewModel?.numberOfJobs() ?? 0) - 1 {
                if viewModel?.fetchNextPage() ?? false {
                    activityIndicatorView.startAnimating()
                }
            }
        }
    }
}

extension JobsViewController: JobsViewModelDelegate {
    func viewModelDidFetchJobs(_ viewModel: JobsViewModel) {
        activityIndicatorView.stopAnimating()
        tableView.reloadData()
    }
    
    func viewModel(_ viewModel: JobsViewModel, didFailWithErrorMessage errorMessage: String) {
        activityIndicatorView.stopAnimating()
        let alert = UIAlertController(title: nil, message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension JobsViewController: SearchVarViewDelegate {
    func searchBarView(_ searchBarView: SearchBarView, didClickSearchWithTitle title: String, andLocation location: String) {
        
        activityIndicatorView.startAnimating()
        viewModel?.fetch(title: title, location: location)
    }
}
