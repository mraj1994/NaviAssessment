//
//  PullRequestViewController.swift
//  Navi Assessment
//
//  Created by Madhvendra raj singh on 03/10/22.
//

import UIKit

class PullRequestViewController: UIViewController {

    @IBOutlet weak var pullRequestTableView: UITableView!
    @IBOutlet weak var loaderView: UIView!
    
    private let viewModel = PullRequestViewModel(pullRequestType: .closed)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewCell()
        self.title = "Pull Requests"
        self.viewModel.reloadData = {[weak self] in
            self?.loaderView.isHidden = true
            self?.pullRequestTableView.reloadData()
        }
        self.viewModel.showFailureAlert = { [weak self] message in
            self?.showFailureAlert(with: message)
        }
    }
    
    private func showFailureAlert(with message : String) {
        let alert = UIAlertController(title: "Failure!", message: message + "Relaunch the app to try again", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    private func setupTableViewCell(){
        self.pullRequestTableView.separatorStyle = .singleLine
        self.pullRequestTableView.register(UINib(nibName: "PullRequestTableViewCell", bundle: nil), forCellReuseIdentifier: "PullRequestTableViewCell")
    }


}

extension PullRequestViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.rowForList()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.getCellForTableView(tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewModel.checkAndLoadMore(tableView, forRowAt: indexPath)
        
    }
    
    
}
