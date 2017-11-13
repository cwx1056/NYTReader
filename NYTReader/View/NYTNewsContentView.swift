//
//  NYTNewsContentView.swift
//  NYTReader
//
//  Created by Tech Netaround on 11/12/17.
//  Copyright © 2017 cwx. All rights reserved.
//

import UIKit

class NYTNewsContentView: UIView {

    lazy fileprivate var authorLabel: UILabel = {
        let newLabel = UILabel()
        return newLabel
    }()
    
    lazy fileprivate var titleLabel: UILabel = {
        let newLabel = UILabel()
        return newLabel
    }()
    
    lazy fileprivate var contentLabel: UILabel = {
        let newLabel = UILabel()
        return newLabel
    }()
    
    lazy fileprivate var dateLabel: UILabel = {
        let newLabel = UILabel()
        return newLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(authorLabel)
        addSubview(titleLabel)
        addSubview(contentLabel)
        addSubview(dateLabel)
        
        layoutInnerViews()
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
    }
    
    // MARK: -
    // MARK: Private methods
    
    fileprivate func layoutInnerViews() {
        
    }
}
