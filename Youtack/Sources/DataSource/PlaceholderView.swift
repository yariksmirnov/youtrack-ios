//
//  PlaceholderView.swift
//  Youtack
//
//  Created by Yarik Smirnov on 05/10/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit
import SwiftyStateMachine
import PureLayout

public struct PlaceholderStateInfo {
    let title: String
    let message: String
}

class PlaceholderView : UIView {
    
    var noContentInfo: PlaceholderStateInfo
    var errorInfo: PlaceholderStateInfo
    var container = UIView()
    
    var titleLabel: UILabel?
    var messageLabel: UILabel?
    
    required init(noContent: PlaceholderStateInfo, error: PlaceholderStateInfo? = nil) {
        self.noContentInfo = noContent
        if let errInfo = error {
            self.errorInfo = errInfo
        } else {
            self.errorInfo = noContentInfo
        }
        super.init(frame: CGRect(x: 0, y: 0, width: 999, height: 999))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not impleemented")
    }
    
    func update(loadState: LoadState) {
        switch loadState {
            case .Idle: container.hidden = true
            case .Load: showLoadingIndicator()
            case .NoContent: layout(noContentInfo)
            case .Error(let error): layout(errorInfo, error: error)
        }
    }
    
    func showLoadingIndicator() {
        
    }
    
    func layout(state: PlaceholderStateInfo, error: NSError? = nil) {
        if container.superview == nil {
            addSubview(container)
            container.autoCenterInSuperview()
        }
        container.subviews.forEach({ $0.removeFromSuperview() })
        var top = ALAttribute.Top
        var view = container
        if !state.title.isEmpty {
            titleLabel = UILabel()
            titleLabel?.text = state.title
            configureTitleLabel(titleLabel!)
            container.addSubview(titleLabel!)
            titleLabel?.autoPinEdgeToSuperviewEdge(.Top)
            titleLabel?.autoAlignAxisToSuperviewAxis(.Vertical)
            view = titleLabel!
            top = .Bottom
        }
        if !state.message.isEmpty {
            messageLabel = UILabel()
            messageLabel?.text = state.message
            configureMessageLabel(messageLabel!)
            container.addSubview(messageLabel!)
            messageLabel?.autoConstrainAttribute(.Top, toAttribute: top, ofView: view)
            messageLabel?.autoAlignAxisToSuperviewAxis(.Vertical)
        }
    }
    
    func configureTitleLabel(label: UILabel) {
        label.numberOfLines = 0
        label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleTitle3)
    }
    
    func configureMessageLabel(label: UILabel) {
        label.numberOfLines = 0
        label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    }
}
