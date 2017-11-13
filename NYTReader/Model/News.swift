//
//  News.swift
//  NYTReader
//
//  Created by Tech Netaround on 11/12/17.
//  Copyright © 2017 cwx. All rights reserved.
//

import Foundation
import SwiftyJSON

struct News {
    var title: String
    var abstract: String?
    var url: String
    var byline: String
    var photo: NewsPhoto?
}

extension News: Decodable {
    static func parse(_ json: JSON, _ decoder: Decoder?) -> News? {
        return decoder?.decode(json) as? News
    }
}

struct NewsJSONDecoder: Decoder {
    func decode(_ json: JSON) -> Any? {
        guard let title = json["title"].string else { return nil }
        guard let url = json["url"].string else { return nil }
        guard let byline = json["byline"].string else { return nil }
        
        let abstract = json["abstract"].string
        let photo = NewsPhoto.parse(json["multimedia"], NewsPhotoJSONDecoder())
        return News(title: title, abstract: abstract, url: url, byline: byline, photo: photo)
    }
}
