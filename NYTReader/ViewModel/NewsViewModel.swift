//
//  NYTNewsViewModel.swift
//  NYTReader
//
//  Created by Tech Netaround on 11/12/17.
//  Copyright © 2017 cwx. All rights reserved.
//

import Foundation

class NewsViewModel {
    
    // MARK: -
    // MARK: Public properties
    
    var news: [News]
    
    // MARK: -
    // MARK: Private properties
    
    fileprivate var offset = 0
    
    // MARK: -
    // MARK: Life cycle
    
    required init(news: [News]) {
        self.news = news
    }
    
    // MARK: -
    // MARK: Public methods
    
    func fetchNews(_ refresh: Bool, _ completion: @escaping (NewsViewModel, Error?) -> Void ) {
        let nextOffset = refresh ? 0 : offset + 1
        
        NYTNewsManager.shared.fetchAllNews(offset: nextOffset) { (data, error) in
            guard error == nil else {
                completion(self, error)
                return
            }
            guard let newData = data, !newData.isEmpty else {
                completion(self, nil)
                return
            }
            
            if nextOffset == 0 {
                self.news.removeAll()
            }
            self.news.append(contentsOf: newData)
            self.offset = nextOffset
            completion(self, nil)
        }
    }
}
