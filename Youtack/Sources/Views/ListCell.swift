//
//  ListCell.swift
//  Youtack
//
//  Created by Yarik Smirnov on 05/11/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {

    var mainTextLabel = UILabel()
    var secondaryTextLabel = UILabel()
    var photoImaveView = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        defaultInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultInit()
    }
    
    func defaultInit() {
        self.contentView.layoutMargins = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
        configureMainText()
        configureSecondaryText()
        configurePhotoImageView()
    }
    
    func configureMainText() {
        mainTextLabel.numberOfLines = 2
        contentView.addSubview(mainTextLabel)
        mainTextLabel.font = R.font.robotoRegular(size: 16)
    }
    
    func configureSecondaryText() {
        contentView.addSubview(secondaryTextLabel)
    }
    
    func configurePhotoImageView() {
        photoImaveView.contentMode = .ScaleAspectFill
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
