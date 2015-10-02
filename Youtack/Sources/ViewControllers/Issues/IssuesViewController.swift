//
//  IssuesViewController.swift
//  Youtack
//
//  Created by Yarik Smirnov on 30/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit
import MaterialDesignColor

class IssuesViewController: UIViewController {
    
    @IBOutlet var searchTextField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = MaterialDesignColor.blue500
    }
    
    @IBAction func onCancelSearch() {
        searchTextField?.resignFirstResponder()
    }

}
