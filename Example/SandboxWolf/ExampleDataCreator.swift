//
//  ExampleDataCreator.swift
//  SandboxManager_Example
//
//  Created by Marcel Hagmann on 23.05.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

class ExampleDataCreator {
    
    static func create10HelloWorldFilesInDocumentDirectory() {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        
        for index in 1...10 {
            let fileName = "Hello World \(index)"
            let data = "Hello Content \(index)".data(using: .utf8)
            
            let destinationURL = documentsDirectory.appendingPathComponent(fileName)
            try? data?.write(to: destinationURL)
        }
    }
    
}
