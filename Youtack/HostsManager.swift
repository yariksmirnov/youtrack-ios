//
//  HostsManager.swift
//  Youtack
//
//  Created by Yarik Smirnov on 24/09/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import Foundation

public class HostsManager {
    static public var instance = HostsManager()
    
    var hosts = [Host]();
    
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
    
    public func loadConfiguredHosts(completion: ((hosts: [Host])-> Void)) {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) {
            let hosts = NSKeyedUnarchiver.unarchiveObjectWithFile(self.configuredHostsFilePath()) as? [Host]
            dispatch_async(dispatch_get_main_queue()) {
                if hosts != nil {
                    self.hosts = hosts!
                }
                completion(hosts: self.hosts)
            }
        }
    }
    
    public func writeConfiguredHosts(completion: ((Void) -> Void)? = nil) {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) {
            NSKeyedArchiver.archiveRootObject(self.hosts, toFile: self.configuredHostsFilePath())
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