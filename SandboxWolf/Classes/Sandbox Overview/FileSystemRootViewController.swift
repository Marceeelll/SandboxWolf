//
//  FileSystemRootViewController.swift
//  SandboxManager
//
//  Created by Marcel Hagmann on 23.05.20.
//  Copyright © 2020 Marcel Hagmann. All rights reserved.
//

import UIKit
import Combine

class FileSystemRootViewController: UIViewController, FileSystemElementPresentable {
    
    private let viewModel: FileSystemRootViewModel
    private var disposables = Set<AnyCancellable>()
    
    init(rootURLs: [URL]) {
        self.viewModel = FileSystemRootViewModel(rootURLs: rootURLs)
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        fileSystemDirectoryView.didSelect = { [weak self] selectedIndex in
            self?.viewModel.didSelect(index: selectedIndex)
        }
        viewModel.$fileSystemElements.receive(on: RunLoop.main)
            .assign(to: \.fileSystemElements, on: fileSystemDirectoryView).store(in: &disposables)
        
        viewModel.delegate = self
        
        view.addSubview(fileSystemDirectoryView)
        
        NSLayoutConstraint.activate(
            [
                fileSystemDirectoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                fileSystemDirectoryView.topAnchor.constraint(equalTo: view.topAnchor),
                fileSystemDirectoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                fileSystemDirectoryView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Subviews
    
    private lazy var fileSystemDirectoryView: FileSystemDirectoryView = {
        let view = FileSystemDirectoryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
}
