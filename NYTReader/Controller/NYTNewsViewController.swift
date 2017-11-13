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
    
    fileprivate var news = [News]()
    fileprivate var offset = 0
    
    lazy fileprivate var refreshControl: UIRefreshControl = {
        let newRefreshControl = UIRefreshControl()
        newRefreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        return newRefreshControl
    }()

    // MARK: -
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTableView.addSubview(refreshControl)
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
        if refresh {
            offset = 0
            news = [News]()
        }
        
        NYTNewsManager.shared.fetchAllNews(offset: offset) { (data, error) in
            guard error == nil else { fatalError("Show Error Messages!!!") }
            guard let newData = data, !newData.isEmpty else { return }
            self.news.append(contentsOf: newData)
            self.offset += 1
            self.newsTableView.reloadData()
            self.refreshControl.endRefreshing()
            self.newsTableView.finishInfiniteScroll()
        }
    }
}

extension NYTNewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.newsTableViewCell, for: indexPath) as! NYTNewsTableViewCell
        cell.setup(with: news[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let url = URL(string: news[indexPath.row].url)!
        let safariController = SFSafariViewController(url: url)
        present(safariController, animated: true, completion: nil)
    }
}
