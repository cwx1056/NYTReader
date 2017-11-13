//
//  Request.swift
//  NYTReader
//
//  Created by Tech Netaround on 11/12/17.
//  Copyright © 2017 cwx. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public protocol Request {
    var path: String { get }
    
    var method: HTTPMethod { get }
    var header: HTTPHeaders? { get }
    var parameter: [String: Any] { get }
    var encoding: ParameterEncoding { get }
    var decoder: Decoder? { get }
    associatedtype Response: Decodable
}
