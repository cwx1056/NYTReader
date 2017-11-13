//
//  Decodable.swift
//  NYTReader
//
//  Created by Tech Netaround on 11/12/17.
//  Copyright © 2017 cwx. All rights reserved.
//

import Foundation
import SwiftyJSON

public protocol Decodable {
    static func parse(_ json: JSON, _ decoder: Decoder?) -> Self?
}

