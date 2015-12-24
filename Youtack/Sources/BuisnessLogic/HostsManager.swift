//
//  HostsManager.swift
//  Youtack
//
//  Created by Yarik Smirnov on 24/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Foundation
import KeychainAccess

public class HostsManager {
    static public var instance = HostsManager()
    
    var hosts = [Host]();
    
    var keychain = Keychain(service: NSBundle.mainBundle().bundleIdentifier!)
    
    var hostsDidChangedHandler: ((hosts: [Host]) -> Void)?
    
    public func addHost(host: Host) {
        hosts.append(host)
        hostsDidChangedHandler?(hosts: hosts)
        writeConfiguredHosts()
    }
    
    public func updateHost(host: Host) {
        guard let idx = hosts.indexOf(host) else {
            preconditionFailure("Updated host not in the configured list: \(host)")
        }
        hosts[idx] = host
        hostsDidChangedHandler?(hosts: hosts)
        writeConfiguredHosts()
    }
    
    public func removeHost(host: Host) {
        guard let idx = hosts.indexOf(host) else {
            preconditionFailure("Remove host not in the configured list: \(host)")
        }
        hosts.removeAtIndex(idx)
        hostsDidChangedHandler?(hosts: hosts)
        writeConfiguredHosts()
    }
    
    public func loadConfiguredHosts(completion: ((hosts: [Host])-> Void)? = nil) {
        guard hosts.count == 0 else {
            completion?(hosts: hosts)
            return
        }
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) {
            if let data = self.keychain[data: "hosts"] {
                let hosts = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [Host]
                dispatch_async(dispatch_get_main_queue()) {
                    self.hosts = hosts ?? []
                    completion?(hosts: self.hosts)
                }
            }
            dispatch_async(dispatch_get_main_queue()) {
                completion?(hosts: self.hosts)
            }
        }
    }
    
    public func writeConfiguredHosts(completion: ((Void) -> Void)? = nil) {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) {
            let data = NSKeyedArchiver.archivedDataWithRootObject(self.hosts)
            self.keychain[data: "hosts"] = data
            dispatch_async(dispatch_get_main_queue()) {
                completion?()
            }
        }
    }
    
    func configuredHostsFilePath() -> String {
        let docDir = NSFileManager.defaultManager().URLsForDirectory(
            .DocumentDirectory,
            inDomains: .UserDomainMask).first
        return (docDir?.URLByAppendingPathComponent("youtrack_hosts.plist").path)!
    }
    
}