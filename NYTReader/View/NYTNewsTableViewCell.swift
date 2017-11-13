//
//  NYTNewsTableViewCell.swift
//  NYTReader
//
//  Created by Tech Netaround on 11/12/17.
//  Copyright © 2017 cwx. All rights reserved.
//

import UIKit
import SnapKit

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
        if let photo = news.photo {
            photoView.setup(with: photo)
        }
        
        newsContentView.setup(with: news)
    }
    
    fileprivate func layoutInnerViews() {
        photoView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.contentView)
        }
        
        newsContentView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(self.contentView)
            make.top.equalTo(self.photoView.snp.bottom)
        }
    }

}
