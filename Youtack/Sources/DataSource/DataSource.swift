//
//  DataSource.swift
//  Youtack
//
//  Created by Yarik Smirnov on 03/10/15.
//  Copyright © 2015 SFCD, LLC. All rights reserved.
//

import UIKit
import SwiftyStateMachine
import Alamofire

enum LoadState: Equatable {
    case Idle, Load, NoContent, Error(NSError?)
}

func == (lhs: LoadState, rhs: LoadState) -> Bool {
    switch (lhs, rhs) {
        case (.Idle, .Idle): return true
        case (.Load, .Load): return true
        case (.NoContent, .NoContent): return true
        case (.Error(_), .Error(_)): return true
        default:
            return false
    }
}

enum Operation: Equatable {
    case Load, FinishLoad, Refresh, FailLoad(NSError?)
}

func == (lhs: Operation, rhs: Operation) -> Bool {
    switch (lhs, rhs) {
        case (.Load, .Load): return true
        case (.FinishLoad, .FinishLoad): return true
        case (.Refresh, .Refresh): return true
        case (.FailLoad(_), .FailLoad(_)): return true
        default:
            return false
    }
}

let schema = StateMachineSchema<LoadState, Operation, Void>(initialState: .Idle) { (state, event) in
    switch state {
        case .Idle: switch event {
            case .Load: return (.Load, nil)
            case .FinishLoad, .Refresh, .FailLoad(_): return nil
        }
        case .Load: switch event {
            case .FinishLoad: return (.Idle, nil)
            case .FailLoad(let error): return (.Error(error), nil)
            case .Load, .Refresh: return nil
        }
        case .NoContent: switch event {
            case .Refresh: return (.Load, nil)
            case .Load, .FinishLoad, .FailLoad(_): return nil
        }
        case .Error(_): switch event {
            case .Refresh: return (.Load, nil)
            case .Load, .FinishLoad, .FailLoad(_): return nil
        }
    }
}

protocol ContentLoading {
    var request: Request? {get set}
    
    func initializeLoader()
    func loadContent(forceUpdate: Bool)
    func cancelLoad()
}

public protocol DataSourceItem: AnyObject, Equatable {}

protocol DataSource: UITableViewDataSource, ContentLoading {
    
    weak var tableViewUpdater: DataSourceTableViewUpdater? {get set}
    weak var contenLoadingDelegate: DataSourceContentLoadingDelegate? {get set}
    
    func registerReusableViews(tableView: UITableView)
    
    func reset()
    
    var numberOfItems: Int {get}
    var dataSourceItems: [AnyObject] {set get}
    
    func dataSourceItem(indexPath: NSIndexPath) -> AnyObject?
}

public protocol ConfigurableCell {
    typealias Item
    func configure(item: Item)
}

public class BasicDataSource<T: DataSourceItem, C: UITableViewCell where C: ConfigurableCell, C.Item == T>: NSObject, ContentLoading, DataSource {
    
    typealias Item = T
    typealias TableCell = C
    
    var items: [Item] = []
    
    var numberOfItems: Int {
        return items.count
    }
    
    var dataSourceItems: [AnyObject] {
        get {
            return items
        }
        set(newItems) {
            if let validItems = newItems as? [Item] {
                items = validItems
            }
        }
    }
    
    weak var tableViewUpdater: DataSourceTableViewUpdater?
    weak var contenLoadingDelegate: DataSourceContentLoadingDelegate?
    
    var placeholder: PlaceholderView?
    typealias Updater = (BasicDataSource) -> NSError?
    var ContentLoader: ((completion: (Updater) -> Void) -> Void)?
    var request: Request?
    var CellIdentifier = ""
    
    let stateMachine: StateMachine<StateMachineSchema<LoadState, Operation, Void>> = StateMachine(
        schema: schema,
        subject: ()
    )
    
    var state: LoadState {
        get {
            return stateMachine.state;
        }
    }
    
    override init() {
        super.init()
        stateMachine.didTransitionCallback = { [weak self] oldState, operation, newState in
            if newState == LoadState.Idle && operation == Operation.FinishLoad {
                self?.stateMachine.state = self?.items.count > 0 ? LoadState.Idle : LoadState.NoContent
            }
            if self?.placeholder != nil {
                self?.updatePlaceholder(nil)
            }
        }
    }
    
    func item(indexPath: NSIndexPath) -> Item? {
        if indexPath.row < items.count {
            return items[indexPath.row]
        }
        return nil
    }
    
    func dataSourceItem(indexPath: NSIndexPath) -> AnyObject? {
        return item(indexPath)
    }
    
    func indexPath(item: Item) -> NSIndexPath? {
        if let index = items.indexOf(item) {
            return NSIndexPath(forRow: index, inSection: 0)
        }
        return nil
    }

    func reset() {
        cancelLoad()
        items.removeAll()
    }
    
    //MARK: ContentLoading
    
    func beginLoading() {
        stateMachine.handleEvent(.Load)
    }
    
    func endLoading(updater: Updater) {
        let error = updater(self)
        if error != nil {
            stateMachine.handleEvent(.FailLoad(error))
        } else {
            stateMachine.handleEvent(.FinishLoad)
        }
        contenLoadingDelegate?.dataSourceDidLoad(self, error: error)
    }
    
    func loadContent(forceUpdate: Bool) {
        if state != LoadState.Load && (items.count == 0 || forceUpdate) {
            dispatch_async(dispatch_get_main_queue()) {
                self._loadContent()
            }
        }
    }
    
    func cancelLoad() {
        ContentLoader = nil
        request?.cancel()
    }
    
    private func _loadContent() {
        initializeLoader()
        stateMachine.handleEvent(.Load)
        ContentLoader?() { [weak self] updater in
            if self?.state == .Load {
               self?.endLoading(updater)
            }
        }
    }
    
    func initializeLoader() {}
    
    //MARK: Placehodler
    
    func shouldDisplayPlaceholer() -> Bool {
        switch state {
            case .NoContent: return true
            case .Load where items.count == 0: return true
            case .Error(_): return true
            default:
                return false
        }
     }
    
    func obscuredByPlaceholder() -> Bool {
        return placeholder != nil && shouldDisplayPlaceholer()
    }
    
    func updatePlaceholder(tableView: UITableView?) {
        if tableView != nil {
            placeholder?.frame = tableView!.bounds
            if placeholder?.superview == nil {
                tableView!.addSubview(placeholder!)
            }
        }
        placeholder?.update(state)
    }

    //MARK: Notifications
    
    func notifyDidReloadData() {
        tableViewUpdater?.dataSourceDidReloadData(self)
    }
    
    func notifyDidUpateItem(item: Item, updateAction: (cell: UITableViewCell) -> Void) {
        if let indexPath = indexPath(item) {
            tableViewUpdater?.dataSource(
                self,
                updateItemAtIndexPath: indexPath,
                updateAction: updateAction
            )
        }
    }
    
    //MARK: UITableViewDataSource
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if obscuredByPlaceholder() {
            updatePlaceholder(tableView)
        }
        return 1
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.cell(indexPath, inTableView: tableView)
        if let item = item(indexPath) {
            configureCell(cell, atIndexPath: indexPath, withEntity: item)
        }
        return cell
    }
    
    func registerReusableViews(tableView: UITableView) {
        tableView.registerClass(TableCell.self, forCellReuseIdentifier: CellIdentifier)
    }
    
    func cell(indexPath: NSIndexPath, inTableView tableView: UITableView) -> TableCell {
        return tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as! TableCell
    }
    
    func configureCell(cell: TableCell, atIndexPath indexPath: NSIndexPath, withEntity entity: Item) {
        cell.configure(entity)
    }
}

protocol DataSourceTableViewUpdater: class {
    func dataSourceDidReloadData<T, C>(dataSource: BasicDataSource<T, C>)
    func dataSource<T, C>(
        dataSource: BasicDataSource<T, C>,
        updateItemAtIndexPath indexPath: NSIndexPath,
        updateAction: (cell: UITableViewCell) -> Void
    )
}

protocol DataSourceContentLoadingDelegate: class {
    func dataSourceDidLoad<T, C>(dataSource: BasicDataSource<T, C>, error: NSError?)
}
