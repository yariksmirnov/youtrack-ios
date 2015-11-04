//
//  MaterialCardsDataSource.swift
//  Youtack
//
//  Created by Yarik Smirnov on 03/11/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit

public class MaterialCardsDataSource<
    T: PaginationItem,
    C: MaterialTableCell where C: ConfigurableCell, C.Item == T> :
    PaginationDataSource<T, C>
{
    
    override init(paginator: Paginator<T>) {
        super.init(paginator: paginator)
    }
    
    override func configureCell(cell: TableCell, atIndexPath indexPath: NSIndexPath, withEntity entity: Item) {
        super.configureCell(cell, atIndexPath: indexPath, withEntity: entity)
        if indexPath.row == 0 {
            cell.cardType = .Top
        } else if indexPath.row == items.count - 1 {
            cell.cardType = .Bottom
        } else {
            cell.cardType = .Middle
        }
    }
}