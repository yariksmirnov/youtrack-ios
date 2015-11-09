//
//  SettingsViewController.swift
//  Youtack
//
//  Created by Yarik Smirnov on 30/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit
import AlamofireImage
import MaterialDesignColor

class SettingsViewController: UITableViewController {
    
    @IBOutlet var photoImageView: UIImageView?
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var usernameLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        User.current.afterChange.add(){ user in
            self.updateCurrentUserInfo()
        }
        updateCurrentUserInfo()
    }
    
    func updateCurrentUserInfo() {
        let user = User.current.value
        let size = (photoImageView?.frame.size.width)! * UIScreen.mainScreen().scale
        if let imageUrl = user?.avatarURL(Int(size)) {
            photoImageView?.af_setImageWithURL(imageUrl)
        } else {
            photoImageView?.image = nil
        }
        nameLabel?.text = user?.fullName
        usernameLabel?.text = "@" + (user?.login ?? "")
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
