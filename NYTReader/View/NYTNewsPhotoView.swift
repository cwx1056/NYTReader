//
//  NYTNewsPhotoView.swift
//  NYTReader
//
//  Created by Tech Netaround on 11/12/17.
//  Copyright © 2017 cwx. All rights reserved.
//

import UIKit
import SnapKit

class NYTNewsPhotoView: UIView {

    lazy fileprivate var photoView: UIImageView = {
        return UIImageView()
    }()
    
    lazy fileprivate var authorLabel: UILabel = {
        let newLabel = UILabel()
        newLabel.numberOfLines = 0
        newLabel.lineBreakMode = .byWordWrapping
        newLabel.textAlignment = .right
        newLabel.font = UIFont(name: "Avenir-Light", size: 8)
        newLabel.textColor = UIColor.black.withAlphaComponent(0.8)
        return newLabel
    }()
    
    init(image: UIImage?) {
        super.init(frame: CGRect.zero)
        photoView.image = image
        addSubview(photoView)
        addSubview(authorLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Public methods
    
    func setup(with newsPhoto: NewsPhoto?) {
        if let photo = newsPhoto {
            authorLabel.text = photo.copyright
            photoView.setImage(with: URL(string: photo.url))
        } else {
            authorLabel.text = nil
            photoView.image = nil
        }
        
        layoutInnerViews(with: newsPhoto)
    }
    
    // MARK: -
    // MARK: Private methods
    
    fileprivate func layoutInnerViews(with newsPhoto: NewsPhoto? = nil) {
        photoView.snp.remakeConstraints { make in
            make.leading.trailing.top.equalTo(self)
            
            if let photo = newsPhoto {
                let ratio = CGFloat(photo.height / photo.width)
                make.height.equalTo(self.photoView.snp.width).multipliedBy(ratio)
            } else {
                make.height.equalTo(0)
            }
        }
        
        authorLabel.snp.remakeConstraints { make in
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.bottom.equalTo(self)
            make.top.equalTo(self.photoView.snp.bottom).offset(3)
            
            if let text = authorLabel.text, !text.isEmpty {
                let height = text.height(withConstrainedWidth: UIScreen.main.bounds.width - 40, font: authorLabel.font)
                make.height.equalTo(height)
            } else {
                make.height.equalTo(0)
            }
        }
    }
}
