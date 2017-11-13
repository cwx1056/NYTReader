//
//  NYTNewsPhotoView.swift
//  NYTReader
//
//  Created by Tech Netaround on 11/12/17.
//  Copyright © 2017 cwx. All rights reserved.
//

import UIKit

class NYTNewsPhotoView: UIView {

    lazy fileprivate var photoView: UIImageView = {
        return UIImageView()
    }()
    
    lazy fileprivate var authorLabel: UILabel = {
        let newLabel = UILabel()
        return newLabel
    }()
    
    init(image: UIImage?) {
        super.init(frame: CGRect.zero)
        photoView.image = image
        addSubview(photoView)
        addSubview(authorLabel)
        
        layoutInnerViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Public methods
    
    func setup(with newsPhoto: NewsPhoto) {

    }
    
    // MARK: -
    // MARK: Private methods
    
    fileprivate func layoutInnerViews() {
        
    }

}
