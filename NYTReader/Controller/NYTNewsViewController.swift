//
//  NYTNewsViewController.swift
//  NYTReader
//
//  Created by Tech Netaround on 11/12/17.
//  Copyright © 2017 cwx. All rights reserved.
//

import UIKit

class NYTNewsViewController: UIViewController {
    
    struct Identifier {
        static let newsTableViewCell = "NYTNewsTableViewCell"
    }
    
    @IBOutlet weak var newsTableView: UITableView! {
        didSet {
            newsTableView.dataSource = self
            newsTableView.delegate = self
            
            newsTableView.register(NYTNewsTableViewCell.self, forCellReuseIdentifier: Identifier.newsTableViewCell)
        }
    }
    
    // MARK: -
    // MARK: Private properties
    
    fileprivate var news = [News]()
    fileprivate var offset = 0

    // MARK: -
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        }
    }
}

extension NYTNewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.newsTableViewCell, for: indexPath) as! NYTNewsTableViewCell
        cell.setup(with: news[indexPath.row])
        return cell
    }
}
