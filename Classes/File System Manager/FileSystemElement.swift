//
//  FileSystemElement.swift
//  SandboxManager
//
//  Created by Marcel Hagmann on 22.05.20.
//  Copyright © 2020 Marcel Hagmann. All rights reserved.
//

import Foundation

public class FileSystemElement {
    var url: URL
    var fileName: String {
        return url.lastPathComponent
    }
    
    init(url: URL) {
        self.url = url
    }
}

class Directory: FileSystemElement {
    
}

class File: FileSystemElement {
    
}
