//
//  FileSystemRootViewModel.swift
//  SandboxManager
//
//  Created by Marcel Hagmann on 23.05.20.
//  Copyright © 2020 Marcel Hagmann. All rights reserved.
//

import Foundation

class FileSystemRootViewModel {
    
    weak var delegate: FileSystemElementPresentable?
    
    @Published private(set) var fileSystemElements: [FileSystemElement]
    
    init(rootURLs: [URL]) {
        self.fileSystemElements = rootURLs.map { FileSystemManager.shared.fileSystemElement(of: $0) }
        print(fileSystemElements)
    }
    
    func didSelect(index: Int) {
        let fileSystemElement = fileSystemElements[index]
        
        delegate?.present(fileSystemElement: fileSystemElement)
    }
    
}
