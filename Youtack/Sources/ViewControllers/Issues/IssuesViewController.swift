//
//  IssuesViewController.swift
//  Youtack
//
//  Created by Yarik Smirnov on 30/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit
import MaterialDesignColor

public class IssuesViewController: ListViewController {
    
    var searchesDataSource: SavedSearchesDataSource? {
        get { return dataSource as? SavedSearchesDataSource }
    }
    @IBOutlet var searchTextField: UITextField?

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = MaterialDesignColor.blue500
    }
    
    override func layoutTableView() {
        super.layoutTableView()
        tableView.autoPinEdgesToSuperviewEdges()
        tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = UIColor(gray: 232)
        tableView.separatorStyle = .None
    }
    
    @IBAction func onCancelSearch() {
        searchTextField?.resignFirstResponder()
    }
    
    override func buildDataSource() -> DataSource? {
        return SavedSearchesDataSource()
    }
    
    //MARK: TableViewDelegate
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let search = searchesDataSource?.item(indexPath) {
            searchTextField?.text = search.text
        }
    }
}
