//
//  CollapsibleTableSectionViewController.swift
//  CollapsibleTableSectionViewController
//
//  Created by Yong Su on 7/20/17.
//  Copyright © 2017 jeantimex. All rights reserved.
//

import UIKit

//
// MARK: - CollapsibleTableSectionDelegate
//
@objc public protocol CollapsibleTableSectionDelegate {
    @objc optional func numberOfSections(_ tableView: UITableView) -> Int
    @objc optional func collapsibleTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    @objc optional func collapsibleTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    @objc optional func collapsibleTableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    @objc optional func collapsibleTableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    @objc optional func collapsibleTableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    @objc optional func collapsibleTableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    @objc optional func shouldCollapseByDefault(_ tableView: UITableView) -> Bool
    @objc optional func shouldCollapseOthers(_ tableView: UITableView) -> Bool
}

//
// MARK: - View Controller
//
open class CollapsibleTableSectionViewController: UIViewController {
    
    public var delegate: CollapsibleTableSectionDelegate?
    
    var tableview: UITableView!
    var sectionsState = [Int : Bool]()
    
    public func isSectionCollapsed(_ section: Int) -> Bool {
        if sectionsState.index(forKey: section) == nil {
            sectionsState[section] = delegate?.shouldCollapseByDefault?(tableview) ?? false
        }
        return sectionsState[section]!
    }
    
    func getSectionsNeedReload(_ section: Int) -> [Int] {
        var sectionsNeedReload = [section]
        
        // Toggle collapse
        let isCollapsed = !isSectionCollapsed(section)
        
        // Update the sections state
        sectionsState[section] = isCollapsed
        
        let shouldCollapseOthers = delegate?.shouldCollapseOthers?(tableview) ?? false
        
        if !isCollapsed && shouldCollapseOthers {
            // Find out which sections need to be collapsed
            let filteredSections = sectionsState.filter { !$0.value && $0.key != section }
            let sectionsNeedCollapse = filteredSections.map { $0.key }
            
            // Mark those sections as collapsed in the state
            for item in sectionsNeedCollapse { sectionsState[item] = true }
            
            // Update the sections that need to be redrawn
            sectionsNeedReload.append(contentsOf: sectionsNeedCollapse)
        }
        
        return sectionsNeedReload
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the tableView
        tableview = UITableView()
        tableview.dataSource = self
        tableview.delegate = self
        
        // Auto resizing the height of the cell
        tableview.estimatedRowHeight = 100.0
        tableview.rowHeight = UITableView.automaticDimension
        
        // Auto layout the tableView
        view.addSubview(tableview)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: bottomLayoutGuide.bottomAnchor).isActive = true
        tableview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableview.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableview.tableFooterView = UIView()
    }
    
}

//
// MARK: - View Controller DataSource and Delegate
//
extension CollapsibleTableSectionViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return delegate?.numberOfSections?(tableView) ?? 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = delegate?.collapsibleTableView?(tableView, numberOfRowsInSection: section) ?? 0
        return isSectionCollapsed(section) ? 0 : numberOfRows
    }
    
    // Cell
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return delegate?.collapsibleTableView?(tableView, cellForRowAt: indexPath) ?? UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "DefaultCell")
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.collapsibleTableView?(tableView, didSelectRowAt: indexPath)
    }
    
    // Header
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        
        let title = delegate?.collapsibleTableView?(tableView, titleForHeaderInSection: section) ?? ""
        
        header.titleLabel.text = title
        /// TODO: Change orientation of arrow
//        header.arrowImageView.text = "v"
        header.setCollapsed(isSectionCollapsed(section))
        
        header.section = section
        header.delegate = self
        
        return header
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return delegate?.collapsibleTableView?(tableView, heightForHeaderInSection: section) ?? 44.0
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return delegate?.collapsibleTableView?(tableView, heightForFooterInSection: section) ?? 0.0
    }
    
}

//
// MARK: - Section Header Delegate
//
extension CollapsibleTableSectionViewController: CollapsibleTableViewHeaderDelegate {
    
    func toggleSection(_ section: Int) {
        let sectionsNeedReload = getSectionsNeedReload(section)
        tableview.reloadSections(IndexSet(sectionsNeedReload), with: .automatic)
    }
    
}
