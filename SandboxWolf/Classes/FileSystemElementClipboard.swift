//
//  FileSystemElementClipboard.swift
//  SandboxManager
//
//  Created by Marcel Hagmann on 23.05.20.
//  Copyright © 2020 Marcel Hagmann. All rights reserved.
//

import Foundation

class FileSystemElementClipboard {
    @Published var fileSystemElement: FileSystemElement?
    
    static var shared = FileSystemElementClipboard()
}
