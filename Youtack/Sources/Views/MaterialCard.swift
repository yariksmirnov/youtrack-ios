//
//  MaterialCard.swift
//  Youtack
//
//  Created by Yarik Smirnov on 03/11/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit

enum MaterialCardType {
    case Top, Middle, Bottom
}

protocol MaterialCard {
    var cardType: MaterialCardType {get set}
}

class MaterialCardView: UIView, MaterialCard {
    var cardType = MaterialCardType.Middle {
        didSet {
            setNeedsLayout()
        }
    }
    var backgroundImageView = UIImageView()
    var separatorImageView = UIImageView()
    var highlighted: Bool = false {
        didSet {
            backgroundImageView.highlighted = highlighted
        }
    }
    
    var contentView = UIView()
    var contentPadding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        defaultInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultInit()
    }
    
    func defaultInit() {
        addBackgroundImageView()
        addSeparator()
        addContentView()
    }
    
    func addContentView() {
        addSubview(contentView)
        contentView.backgroundColor = UIColor.clearColor()
    }
    
    func addBackgroundImageView() {
        addSubview(backgroundImageView)
    }
    
    func addSeparator() {
        addSubview(separatorImageView)
        separatorImageView.image = R.image.gDDGroupedCellBGMiddleSeparator
        separatorImageView.highlightedImage = R.image.gDDGroupedCellBGMiddleSeparatorHighlighted
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var backgroundInsets = UIEdgeInsets(
            top: contentPadding.top - 3,
            left: contentPadding.left - 2,
            bottom: contentPadding.bottom - 4,
            right: contentPadding.right - 2
        )
        var contentInsets = contentPadding
        var normalBG: UIImage?
        var highlightedBG: UIImage?
        separatorImageView.hidden = false
        switch cardType {
            case .Top:
                backgroundInsets.bottom = 0
                contentInsets.bottom = 0
                normalBG = R.image.gDDGroupedCellBGTop
                highlightedBG = R.image.gDDGroupedCellBGTopHighlighted
            case .Middle:
                backgroundInsets.top = 0
                contentInsets.top = 0
                backgroundInsets.bottom = 0
                contentInsets.bottom = 0
                normalBG = R.image.gDDGroupedCellBGMiddle
                highlightedBG = R.image.gDDGroupedCellBGMiddleHighlighted
            case .Bottom:
                backgroundInsets.top = 0
                contentInsets.top = 0
                normalBG = R.image.gDDGroupedCellBGBottom
                highlightedBG = R.image.gDDGroupedCellBGBottomHighlighted
                separatorImageView.hidden = true
        }
        backgroundImageView.frame = UIEdgeInsetsInsetRect(bounds, backgroundInsets)
        contentView.frame = UIEdgeInsetsInsetRect(bounds, contentInsets)
        backgroundImageView.image = normalBG
        backgroundImageView.highlightedImage = highlightedBG
        separatorImageView.frame = CGRect(
            x: contentPadding.left - 2,
            y: bounds.size.height - 2,
            width: bounds.size.width - (contentPadding.left - 2)*2,
            height: 2
        )
    }
}
