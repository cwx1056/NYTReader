//
//  Decoder.swift
//  NYTReader
//
//  Created by Tech Netaround on 11/12/17.
//  Copyright © 2017 cwx. All rights reserved.
//

import Foundation
import SwiftyJSON

public protocol Decoder {
    func decode(_ json: JSON) -> Any?
}
