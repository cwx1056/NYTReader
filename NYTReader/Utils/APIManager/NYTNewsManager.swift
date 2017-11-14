//
//  NYTAPIManager.swift
//  NYTReader
//
//  Created by Tech Netaround on 11/12/17.
//  Copyright © 2017 cwx. All rights reserved.
//

import Foundation

struct NYTNewsManager {
    
    private struct Keys {
        static let newswireKey = "1bb8f9fc2c474293a63dc5a666ab4113"
    }

    // MARK: -
    // MARK: Public properties
    
    static let shared = NYTNewsManager()

    // MARK: -
    // MARK: Life cycle
    
    private init() {
        
    }
    
    // MARK: -
    // MARK: Public mehtods
    
    func fetchAllNews(limit: Int = 20, offset: Int = 0, _ completion: @escaping ([News]?, Error?) -> Void) {
        let parameter: [String: Any] = ["api_key": Keys.newswireKey,
                                        "limit": limit,
                                        "offset": offset]
        NYTClient().promise(NYTNewswireRequest(parameter: parameter)).then { collection -> Void in
            completion(collection.news, nil)
        }.catch { error in
            completion(nil, error)
        }
    }
    
}
