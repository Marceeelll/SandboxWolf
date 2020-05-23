//
//  FileSystemElementPresentable.swift
//  SandboxManager
//
//  Created by Marcel Hagmann on 23.05.20.
//  Copyright © 2020 Marcel Hagmann. All rights reserved.
//

import UIKit

protocol FileSystemElementPresentable: AnyObject {
    func present(fileSystemElement: FileSystemElement)
}

extension FileSystemElementPresentable where Self: UIViewController {
    
    func present(fileSystemElement: FileSystemElement) {
        let viewModel = FileSystemDirectoryViewModel(fileSystemURL: fileSystemElement.url)
        let fileSystemFolderViewController = FileSystemDirectoryViewController(viewModel: viewModel)
        
        navigationController?.pushViewController(fileSystemFolderViewController, animated: true)
    }
    
}
