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
    
    lazy fileprivate var photoView: UIImageView = {
        let newImageView = UIImageView()
        newImageView.contentMode = .scaleAspectFill
        return newImageView
    }()
    
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
        newLabel.font = UIFont(name: "Avenir-Light", size: 12)
        newLabel.textColor = UIColor.lightGray.withAlphaComponent(0.75)
        return newLabel
    }()
    
    lazy fileprivate var photoAuthorLabel: UILabel = {
        let newLabel = UILabel()
        newLabel.numberOfLines = 0
        newLabel.lineBreakMode = .byWordWrapping
        newLabel.textAlignment = .right
        newLabel.font = UIFont(name: "Avenir-Light", size: 8)
        newLabel.textColor = UIColor.black.withAlphaComponent(0.8)
        return newLabel
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(photoView)
        contentView.addSubview(photoAuthorLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(authorLabel)
        
        layoutInnerViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with news: News) {
        if let photo = news.photo {
            photoAuthorLabel.text = photo.copyright
            photoView.setImage(with: URL(string: photo.url)!)
            updatePhotoView(CGFloat(photo.height / photo.width))
        } else {
            photoAuthorLabel.text = nil
            photoView.image = nil
            updatePhotoView(0)
        }
        
        authorLabel.text = news.byline
        titleLabel.text = news.title
        contentLabel.text = news.abstract
        dateLabel.text = news.date.toNewsDateString()
    }
    
    fileprivate func layoutInnerViews() {
        photoView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(self.contentView)
        }
        
        photoAuthorLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.contentView).offset(15)
            make.trailing.equalTo(self.contentView).offset(-15)
            make.top.equalTo(self.photoView.snp.bottom).offset(3)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.contentView).offset(25)
            make.trailing.equalTo(self.contentView).offset(-25)
            make.top.equalTo(self.photoAuthorLabel.snp.bottom).offset(5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.contentView).offset(25)
            make.trailing.equalTo(self.contentView).offset(-25)
            make.top.equalTo(self.authorLabel.snp.bottom).offset(3)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.titleLabel)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(8)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.contentLabel)
            make.top.equalTo(self.contentLabel.snp.bottom).offset(10)
            make.bottom.equalTo(self.contentView).offset(-20)
        }
    }
    
    fileprivate func updatePhotoView(_ ratio: CGFloat) {
        photoView.snp.remakeConstraints { make in
            make.leading.trailing.top.equalTo(self.contentView)
            make.height.equalTo(self.photoView.snp.width).multipliedBy(ratio).priority(999)
        }
    }

}
