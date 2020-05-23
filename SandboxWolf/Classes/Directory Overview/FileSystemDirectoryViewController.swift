//
//  FileSystemDirectoryViewController.swift
//  SandboxManager
//
//  Created by Marcel Hagmann on 22.05.20.
//  Copyright © 2020 Marcel Hagmann. All rights reserved.
//

import UIKit
import Combine

class FileSystemDirectoryViewController: UIViewController, FileSystemDirectoryViewModelDelegate {
    
    private var disposables = Set<AnyCancellable>()
    private let viewModel: FileSystemDirectoryViewModel
    
    init(viewModel: FileSystemDirectoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        fileSystemDirectoryView.didSelect = { [weak self] selectedIndex in
            self?.viewModel.didSelect(index: selectedIndex)
        }
        fileSystemDirectoryView.didDelete = { [weak self] deletedIndex in
            self?.viewModel.didDelete(index: deletedIndex)
        }
        
        viewModel.$fileSystemElements.receive(on: RunLoop.main)
            .assign(to: \.fileSystemElements, on: fileSystemDirectoryView).store(in: &disposables)
        
        FileSystemElementClipboard.shared.$fileSystemElement.receive(on: RunLoop.main)
            .assign(to: \.fileSystemElement, on: self).store(in: &disposables)
        
        view.addSubview(fileSystemDirectoryView)
        
        NSLayoutConstraint.activate(
            [
                fileSystemDirectoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                fileSystemDirectoryView.topAnchor.constraint(equalTo: view.topAnchor),
                fileSystemDirectoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                fileSystemDirectoryView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        )
        
        let moveButton = UIBarButtonItem(title: "Move",
                                         style: .done,
                                         target: self,
                                         action: #selector(performMoveFileSystemElementAction))
        let copyButton = UIBarButtonItem(title: "Copy",
                                         style: .done,
                                         target: self,
                                         action: #selector(performCopyFileSystemElementAction))
        
        navigationItem.rightBarButtonItems = [moveButton, copyButton]
        
        viewModel.loadFileSystemElements()
    }
    
    var fileSystemElement: FileSystemElement? {
        didSet {
            navigationItem.rightBarButtonItems?.forEach {
                $0.isEnabled = fileSystemElement != nil
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc private func performMoveFileSystemElementAction() {
        viewModel.didTapMoveToThisLocation()
    }
    
    @objc private func performCopyFileSystemElementAction() {
        viewModel.didTapCopyToThisLocation()
    }
    
    // MARK: - FileSystemFolderViewModelDelegate
    
    func present(errorAlert: UIAlertController) {
        present(errorAlert, animated: true)
    }
    
    func presentRenameDialog(_ viewController: UIViewController) {
        present(viewController, animated: true)
    }
    
    func presentFileSystemElementOptionMenu(_ optionMenu: UIViewController) {
        present(optionMenu, animated: true)
    }
    
    // MARK: - Subviews
    
    private lazy var fileSystemDirectoryView: FileSystemDirectoryView = {
        let view = FileSystemDirectoryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
}
