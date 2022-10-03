//
//  PullRequestViewModel.swift
//  Navi Assessment
//
//  Created by Madhvendra raj singh on 03/10/22.
//

import UIKit

enum PullRequestType: String {
    case closed = "close"
    case all
    
    static func getState(type: String) -> Self {
        if type == "closed" {
            return .closed
        } else {
            return .all
        }
    }
}


class PullRequestViewModel {
    
    private var pullRequestType:PullRequestType
    var reloadData:(()->Void)?
    var showFailureAlert:((String)->Void)?
    private var pageNumber = 1 {
        didSet {
            self.loadMoreData(for: pageNumber)
        }
    }
    var pullRequestData:[PullRequestResponseModel]? {
        didSet {
            reloadData?()
        }
    }
    
    public init(pullRequestType: PullRequestType){
        self.pullRequestType = pullRequestType
        fetchPullRequests(pullRequestType: pullRequestType.rawValue, pageNumber: 1)
    }
    
    private func fetchPullRequests(pullRequestType: String, pageNumber: Int, itemsPerPage: Int = 10){
        APIManager.getPullRequest(state: pullRequestType, pageNumber: pageNumber, itemsPerPage: itemsPerPage) { [weak self](response) in
            switch response {
            case .success(let pullRequestData):
                if self?.pullRequestData == nil {
                    self?.pullRequestData = pullRequestData
                } else {
                    self?.pullRequestData?.append(contentsOf: pullRequestData)
                }
            case.failure(let error):
                DispatchQueue.main.async {
                    self?.showFailureAlert?(error.localizedDescription)
                }
            }
        }
    }
    
    private func loadMoreData(for page: Int){
        fetchPullRequests(pullRequestType: self.pullRequestType.rawValue, pageNumber: page)
    }
    
    func checkAndLoadMore(_ tableView: UITableView, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            //pagination logic
            let currentDataCount = self.pullRequestData?.count ?? 0
            if indexPath.row + 1 == currentDataCount {
                self.pageNumber += 1
            }
        }
    }
    
    
    func rowForList() -> Int {
        self.pullRequestData?.count ?? 0
    }
    
    func getCellForTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PullRequestTableViewCell.self), for: indexPath) as? PullRequestTableViewCell else {
            return UITableViewCell()
        }
        if let data = self.pullRequestData?[indexPath.row] {
            cell.setupData(data: data)
        }
        cell.selectionStyle = .none
        return cell
    }
    
}
