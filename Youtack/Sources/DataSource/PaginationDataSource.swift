//
// Created by Yarik Smirnov on 29/10/15.
// Copyright (c) 2015 SFCD, LLC. All rights reserved.
//

import Foundation
import Mantle

public protocol PaginationItem: DataSourceItem, MTLJSONSerializing {}

extension Object: PaginationItem {}

public class PaginationDataSource<T: PaginationItem, C: UITableViewCell where C: ConfigurableCell, C.Item == T > : BasicDataSource<T, C> {

    var paginator: Paginator<T>

    init (paginator: Paginator<T>) {
        self.paginator = paginator
        super.init()
    }
    
    override func initializeLoader() {
        ContentLoader = { [weak self] completion in
            self?.paginator.load() { (items: [T], error) in
                completion() { dataSource in
                    dataSource.items = items
                    dataSource.notifyDidReloadData()
                    return error
                }
            }
        }
    }
    
}