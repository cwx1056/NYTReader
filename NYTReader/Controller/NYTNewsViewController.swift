//
//  NYTNewsViewController.swift
//  NYTReader
//
//  Created by Tech Netaround on 11/12/17.
//  Copyright © 2017 cwx. All rights reserved.
//

import UIKit
import SafariServices
import UIScrollView_InfiniteScroll

class NYTNewsViewController: UIViewController {
    
    struct Identifier {
        static let newsTableViewCell = "NYTNewsTableViewCell"
    }
    
    @IBOutlet weak var newsTableView: UITableView! {
        didSet {
            newsTableView.dataSource = self
            newsTableView.delegate = self
            newsTableView.separatorInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
            newsTableView.register(NYTNewsTableViewCell.self, forCellReuseIdentifier: Identifier.newsTableViewCell)
            newsTableView.addInfiniteScroll { [weak self] tableView in
                guard let strongSelf = self else { return }
                strongSelf.fetchNews(false)
            }
        }
    }
    
    // MARK: -
    // MARK: Private properties
    
    fileprivate var newsViewModel = NewsViewModel(news: [])
    
    lazy fileprivate var refreshControl: UIRefreshControl = {
        let newRefreshControl = UIRefreshControl()
        newRefreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        return newRefreshControl
    }()
    
    lazy fileprivate var titleLabel: UILabel = {
        let newLabel = UILabel()
        newLabel.font = UIFont(name: "Olde English", size: 30)
        newLabel.text = "The New York Times"
        return newLabel
    }()

    // MARK: -
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTableView.addSubview(refreshControl)
        navigationItem.titleView = titleLabel
        refreshNews()
    }
    
    // MARK: -
    // MARK: Events response
    
    @objc fileprivate func refreshNews() {
        fetchNews(true)
    }

    // MARK: -
    // MARK: Private methods
    
    fileprivate func fetchNews(_ refresh: Bool) {
        newsViewModel.fetchNews(refresh) { [weak self] (viewModel, error) in
            guard let strongSelf = self else { return }
            guard error == nil else {
                strongSelf.showAlert("Failed to load news, please try again later!")
                return
            }
            
            strongSelf.newsTableView.reloadData()
            strongSelf.refreshControl.endRefreshing()
            strongSelf.newsTableView.finishInfiniteScroll()
        }
    }
    
    fileprivate func showAlert(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

extension NYTNewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel.news.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 380
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.newsTableViewCell, for: indexPath) as! NYTNewsTableViewCell
        cell.setup(with: newsViewModel.news[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let url = URL(string: newsViewModel.news[indexPath.row].url)!
        let safariController = SFSafariViewController(url: url)
        present(safariController, animated: true, completion: nil)
    }
}
