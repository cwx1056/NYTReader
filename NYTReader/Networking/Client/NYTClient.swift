//
//  NYTClient.swift
//  NYTReader
//
//  Created by Tech Netaround on 11/12/17.
//  Copyright © 2017 cwx. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct NYTClient: Client {
    var host: String = "https://api.nytimes.com/svc/news"
    
    func send<T>(_ r: T, _ handler: @escaping (Result<T.Response>) -> ()) where T : Request {
        let url = URL(string: host.appending(r.path))!
        let request = Alamofire.request(url, method: r.method, parameters: r.parameter, encoding: r.encoding, headers: r.header)
        print(url)
        
        request.validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let res = T.Response.parse(json, r.decoder) {
                    handler(.success(res))
                }
            case .failure(let error):
                print(response.debugDescription)
                print(response.description)
                handler(.failure(error))
            }
        }
    }
    
    
}
