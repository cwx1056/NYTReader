//
//  NewsCollection.swift
//  NYTReader
//
//  Created by Tech Netaround on 11/12/17.
//  Copyright © 2017 cwx. All rights reserved.
//

import Foundation
import SwiftyJSON

struct NewsCollection {
    var news: [News]
}

extension NewsCollection: Decodable {
    static func parse(_ json: JSON, _ decoder: Decoder?) -> NewsCollection? {
        return decoder?.decode(json) as? NewsCollection
    }
}

struct NewsCollectionJSONDecoder: Decoder {
    func decode(_ json: JSON) -> Any? {
        guard let items = json["results"].array else { return nil }
        var newsArr = [News]()
        for item in items {
            if let news = News.parse(item, NewsJSONDecoder()) {
                newsArr.append(news)
            }
        }
        
        return NewsCollection(news: newsArr)
    }
}
