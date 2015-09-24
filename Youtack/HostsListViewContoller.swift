//
//  ViewController.swift
//  Youtack
//
//  Created by Yarik Smirnov on 23/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit

class HostsListViewController: UITableViewController, HostDetailsViewContorllerDelegate {

    var hosts = [Host]()
    let HostCellIdentifier = "HostCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem()
        
        HostsManager.instance.hostsDidChangedHandler = { hosts in
            self.hostsDidChanged(hosts)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadHosts()
    }
    
    func loadHosts() {
        HostsManager.instance.loadConfiguredHosts() { hosts in
            self.hostsDidChanged(hosts)
        }
    }
    
    func hostsDidChanged(newHosts: [Host]) {
        hosts = newHosts
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController.childViewControllers.first is HostDetailsViewController {
            let newHostVC = segue.destinationViewController.childViewControllers.first as! HostDetailsViewController
            newHostVC.delegate = self
            if segue.identifier == HostDetailsViewController.HostDetailsSegueIdentifier {
                let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
                newHostVC.host = hosts[(indexPath?.row)!]
            }
        }
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
    }
    
    //MARK: HostDetailsViewContorllerDelegate
    
    func hostDetails(hostDetails: HostDetailsViewController, didFinishWithNewHost host: Host) {
        HostsManager.instance.addHost(host)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func hostDetails(hostDetails: HostDetailsViewController, didEditHost host: Host) {
        HostsManager.instance.updateHost(host)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func hostDetailsDidCancel(hostDetails: HostDetailsViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: TableView Delegate & DataSource

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hosts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(HostCellIdentifier,
            forIndexPath: indexPath) as! HostCell
        cell.configure(hosts[indexPath.row])
        return cell
    }
    
    override func tableView(tableView: UITableView,
        commitEditingStyle editingStyle: UITableViewCellEditingStyle,
        forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .Delete {
            let deletedHost = hosts.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Top)
            HostsManager.instance.removeHost(deletedHost)
        }
    }
}

