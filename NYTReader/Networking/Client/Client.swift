//
//  Client.swift
//  NYTReader
//
//  Created by Tech Netaround on 11/12/17.
//  Copyright © 2017 cwx. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire

enum Result<T> {
    case success(T)
    case failure(Error)
}

protocol Client {
    var host: String { get }
    func send<T: Request>(_ r: T, _ handler: @escaping (Result<T.Response>) -> ())
}

extension Client {
    func promise<T: Request>(_ r: T) -> Promise<T.Response> {
        return Promise { fullfill, reject in
            self.send(r) { result in
                switch result {
                case .success(let res):
                    fullfill(res)
                case .failure(let error):
                    reject(error)
                }
            }
        }
    }
}

