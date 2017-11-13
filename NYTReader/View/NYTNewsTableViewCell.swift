//
//  NYTNewsTableViewCell.swift
//  NYTReader
//
//  Created by Tech Netaround on 11/12/17.
//  Copyright © 2017 cwx. All rights reserved.
//

import UIKit

class NYTNewsTableViewCell: UITableViewCell {
    
    lazy fileprivate var photoView: NYTNewsPhotoView = {
        return NYTNewsPhotoView(image: nil)
    }()
    
    lazy fileprivate var newsContentView: NYTNewsContentView = {
        return NYTNewsContentView()
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(photoView)
        contentView.addSubview(newsContentView)
        
        layoutInnerViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with news: News) {
        
    }
    
    fileprivate func layoutInnerViews() {
        
    }

}
