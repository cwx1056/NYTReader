//
//  ImageCacher.swift
//  NYTReader
//
//  Created by Tech Netaround on 11/14/17.
//  Copyright © 2017 cwx. All rights reserved.
//

import UIKit

class ImageCacher {
    static let shared = ImageCacher()
    
    fileprivate var cache = [String: UIImage]()
    
    func getImage(_ urlStr: String) -> UIImage? {
        return cache[urlStr]
    }
    
    func saveImage(_ urlStr: String, _ image: UIImage) {
        cache[urlStr] = image
    }
}
