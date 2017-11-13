//
//  NYTNewsContentView.swift
//  NYTReader
//
//  Created by Tech Netaround on 11/12/17.
//  Copyright © 2017 cwx. All rights reserved.
//

import UIKit
import SnapKit

class NYTNewsContentView: UIView {

    lazy fileprivate var authorLabel: UILabel = {
        let newLabel = UILabel()
        newLabel.numberOfLines = 0
        newLabel.lineBreakMode = .byWordWrapping
        newLabel.font = UIFont(name: "Avenir-Light", size: 10)
        return newLabel
    }()
    
    lazy fileprivate var titleLabel: UILabel = {
        let newLabel = UILabel()
        newLabel.numberOfLines = 0
        newLabel.lineBreakMode = .byWordWrapping
        newLabel.font = UIFont(name: "Avenir-Heavy", size: 16)
        return newLabel
    }()
    
    lazy fileprivate var contentLabel: UILabel = {
        let newLabel = UILabel()
        newLabel.numberOfLines = 0
        newLabel.lineBreakMode = .byWordWrapping
        newLabel.font = UIFont(name: "Avenir", size: 14)
        return newLabel
    }()
    
    lazy fileprivate var dateLabel: UILabel = {
        let newLabel = UILabel()
        newLabel.numberOfLines = 0
        newLabel.lineBreakMode = .byWordWrapping
        return newLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(authorLabel)
        addSubview(titleLabel)
        addSubview(contentLabel)
        addSubview(dateLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Public methods

    func setup(with news: News) {
        authorLabel.text = news.byline
        titleLabel.text = news.title
        contentLabel.text = news.abstract
        
        layoutInnerViews()
    }
    
    // MARK: -
    // MARK: Private methods
    
    fileprivate func layoutInnerViews() {
        authorLabel.snp.remakeConstraints { make in
            make.leading.equalTo(self).offset(25)
            make.trailing.equalTo(self).offset(-25)
            make.top.equalTo(self).offset(5)
            
            if let text = self.authorLabel.text, !text.isEmpty {
                let height = text.height(withConstrainedWidth: UIScreen.main.bounds.width - 50, font: self.authorLabel.font)
                make.height.equalTo(height)
            } else {
                make.height.equalTo(0)
            }
        }
        
        titleLabel.snp.remakeConstraints { make in
            make.leading.equalTo(self).offset(25)
            make.trailing.equalTo(self).offset(-25)
            make.top.equalTo(self.authorLabel.snp.bottom).offset(3)
            
            if let text = self.titleLabel.text, !text.isEmpty {
                let height = text.height(withConstrainedWidth: UIScreen.main.bounds.width - 50, font: self.titleLabel.font)
                make.height.equalTo(height)
            } else {
                make.height.equalTo(0)
            }
        }
        
        contentLabel.snp.remakeConstraints { make in
            make.leading.trailing.equalTo(self.titleLabel)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(8)
            make.bottom.equalTo(self).offset(-15)
//
//            if let text = self.contentLabel.text, !text.isEmpty {
//                let height = text.height(withConstrainedWidth: UIScreen.main.bounds.width - 30, font: self.contentLabel.font)
//                make.height.equalTo(height)
//            }
        }
    }
}
