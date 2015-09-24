//
//  HostDetailsViewController.swift
//  Youtack
//
//  Created by Yarik Smirnov on 24/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit

protocol HostDetailsViewContorllerDelegate: class {
    func hostDetails(hostDetails: HostDetailsViewController, didFinishWithNewHost host: Host)
    func hostDetails(hostDetails: HostDetailsViewController, didEditHost host: Host)
    func hostDetailsDidCancel(hostDetails: HostDetailsViewController)
}

class HostDetailsViewController: UITableViewController {
    
    static let NewHostSegueIdentifier = "NewHostSegueIdentifier"
    static let HostDetailsSegueIdentifier = "HostDetailsSegueIdentifier"

    weak var delegate: HostDetailsViewContorllerDelegate?
    var host: Host?
    
    @IBOutlet var titleTextField: UITextField?
    @IBOutlet var hostTextField: UITextField?
    @IBOutlet var sslSwitch: UISwitch?

    override func viewDidLoad() {
        super.viewDidLoad()
        if host == nil {
            titleTextField?.becomeFirstResponder()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if host != nil {
            installValues()
        }
    }
    
    func installValues() {
        titleTextField?.text = host?.title
        hostTextField?.text = host?.url
        sslSwitch?.on = (host?.requiredSSL)!
    }
    
    @IBAction func onDone() {
        if let editingHost = host {
            updateHostInfo(editingHost)
            delegate?.hostDetails(self, didEditHost: editingHost)
        } else {
            if let newHost = buildNewHost() {
                delegate?.hostDetails(self, didFinishWithNewHost: newHost)
            }
        }
    }
    
    func buildNewHost() -> Host? {
        return updateHostInfo(Host())
    }
    
    func updateHostInfo(host: Host) -> Host? {
        host.title = titleTextField?.text
        host.url = hostTextField?.text
        host.requiredSSL = (sslSwitch?.on)!
        guard host.valid else {
            return nil
        }
        return host
    }
    
    @IBAction func onCancel() {
        delegate?.hostDetailsDidCancel(self)
    }

}
