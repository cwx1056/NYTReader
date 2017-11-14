//
//  UIImageView+Util.swift
//  NYTReader
//
//  Created by Tech Netaround on 11/13/17.
//  Copyright © 2017 cwx. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
    func setImage(with url: URL?) {
        guard let urlStr = url?.absoluteString else { return }
        
        if let image = ImageCacher.shared.getImage(urlStr) {
            self.image = image
        } else {
            Alamofire.request(urlStr).responseImage { response in
                if let image = response.result.value {
                    self.image = image
                }
            }
        }
    }
}
