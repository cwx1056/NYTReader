//
//  NYTNewswireRequest.swift
//  NYTReader
//
//  Created by Tech Netaround on 11/12/17.
//  Copyright © 2017 cwx. All rights reserved.
//

import Foundation
import Alamofire

struct NYTNewswireRequest: Request {
    typealias Response = NewsCollection
    
    var path: String
    let method: HTTPMethod = .get
    var header: HTTPHeaders?
    var parameter: [String : Any]
    var encoding: ParameterEncoding = URLEncoding.default
    var decoder: Decoder? = NewsCollectionJSONDecoder()
    
    init(source: String = "all", section: String = "all", header: HTTPHeaders? = nil, parameter: [String: Any]) {
        self.path = "/v3/content/\(source)/\(section)/null.json"
        self.header = header
        self.parameter = parameter
    }
}
