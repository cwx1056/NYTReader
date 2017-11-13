//
//  Date+Util.swift
//  NYTReader
//
//  Created by Tech Netaround on 11/12/17.
//  Copyright © 2017 cwx. All rights reserved.
//

import Foundation

extension Date {
    
    func toNewsDateString() -> String {
        let timeInterval = -self.timeIntervalSinceNow
        var temp = Int(timeInterval)
        guard temp >= 60 else { return "just now" }
        
        temp /= 60
        guard temp >= 60 else { return temp == 1 ? "1 minute ago" : "\(temp) minutes ago" }
        
        temp /= 60
        guard temp >= 24 else { return temp == 1 ? "1 hour ago" : "\(temp) hours ago" }
        
        temp /= 24
        guard temp >= 30 else { return temp == 1 ? "1 day ago" : "\(temp) days ago" }
        
        temp /= 30
        guard temp >= 12 else { return temp == 1 ? "1 month ago" : "\(temp) months ago" }
        
        temp /= 12
        return temp == 1 ? "1 year ago" : "\(temp) years ago"
    }
}
