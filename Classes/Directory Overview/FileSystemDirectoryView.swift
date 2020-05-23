//
//  FileSystemDirectoryView.swift
//  SandboxManager
//
//  Created by Marcel Hagmann on 22.05.20.
//  Copyright © 2020 Marcel Hagmann. All rights reserved.
//

import UIKit

class FileSystemDirectoryView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    var didSelect: ((Int) -> Void)?
    var didDelete: ((Int) -> Void)?
    
    var fileSystemElements = [FileSystemElement]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(tableView)
        
        NSLayoutConstraint.activate(
            [
                tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                tableView.topAnchor.constraint(equalTo: topAnchor),
                tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
        )
    }
    
    // MARK: - Subviews
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileSystemElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = String(describing: UITableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        let content = fileSystemElements[indexPath.row]
        let fileName = content.fileName
        
        cell.accessoryType = content is Directory ? .disclosureIndicator : .none
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = fileName
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect?(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            didDelete?(indexPath.row)
        }
    }
    
}
