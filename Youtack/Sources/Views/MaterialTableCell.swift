//
//  MaterialTableCell.swift
//  Youtack
//
//  Created by Yarik Smirnov on 03/11/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit

public class CardTableCell: UITableViewCell, MaterialCard {
    var materialCardView: CardView = CardView()
    
    var cardType: MaterialCardType {
        set { materialCardView.cardType = newValue }
        get { return materialCardView.cardType }
    }
    
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        defaultInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultInit()
    }
    
    func defaultInit() {
        selectionStyle = .None
        backgroundColor = UIColor.clearColor()
        contentView.addSubview(materialCardView)
        materialCardView.autoPinEdgesToSuperviewEdges()
    }
}