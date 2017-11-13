//
//  NewsPhoto.swift
//  NYTReader
//
//  Created by Tech Netaround on 11/12/17.
//  Copyright © 2017 cwx. All rights reserved.
//

import Foundation
import SwiftyJSON

enum NewsPhotoFormat {
    case standardThumbnail, normal, mediumThreeByTwo210, mediumThreeByTwo440
}

struct NewsPhoto {
    var height: Float
    var width: Float
    var url: String
    var caption: String?
    var copyright: String?
}

extension NewsPhoto: Decodable {
    static func parse(_ json: JSON, _ decoder: Decoder?) -> NewsPhoto? {
        return decoder?.decode(json) as? NewsPhoto
    }
}

struct NewsPhotoJSONDecoder: Decoder {
    func decode(_ json: JSON) -> Any? {
        guard let multimedia = json.array else { return nil }
        var photoJSON: JSON?
        for media in multimedia {
            guard let type = media["type"].string, type == "image" else { continue }
            guard let format = media["format"].string, format == "mediumThreeByTwo440" else { continue }
            photoJSON = media
        }
        
        guard let photo = photoJSON else { return nil }
        guard let height = photo["height"].float else { return nil }
        guard let width = photo["width"].float else { return nil }
        guard let url = photo["url"].string else { return nil }
        
        let caption = photo["caption"].string
        let copyright = photo["copyright"].string
        
        return NewsPhoto(height: height, width: width, url: url, caption: caption, copyright: copyright)
    }
}
