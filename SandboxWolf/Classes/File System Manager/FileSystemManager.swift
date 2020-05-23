//
//  FileSystemManager.swift
//  SandboxManager
//
//  Created by Marcel Hagmann on 22.05.20.
//  Copyright © 2020 Marcel Hagmann. All rights reserved.
//

import Foundation

class FileSystemManager {
    
    private let fileManager: FileManager
    
    public static let shared = FileSystemManager()
    
    private init(fileManager: FileManager = FileManager.default) {
        self.fileManager = fileManager
    }
    
    func fileSystemElement(of url: URL) -> FileSystemElement {
        if isDirectory(atPath: url.path) {
            return Directory(url: url)
        } else {
            return File(url: url)
        }
    }
    
    func contentsOf(url: URL) -> [FileSystemElement] {
        guard let directoryFileNames = try? fileManager.contentsOfDirectory(atPath: url.path) else { return [] }
        
        var content = [FileSystemElement]()
        
        for fileName in directoryFileNames {
            let fileURL = url.appendingPathComponent(fileName)
            let element = fileSystemElement(of: fileURL)
            
            content.append(element)
        }
        
        return content
    }
    
    private func isDirectory(atPath path: String) -> Bool {
        let isDirectory: UnsafeMutablePointer<ObjCBool>? = .allocate(capacity: 1)
        
        if fileManager.fileExists(atPath: path, isDirectory: isDirectory) {
            return isDirectory?.pointee.boolValue == true
        }
        
        return false
    }
    
    func copy(_ fileSystemElement: FileSystemElement,
              toDestination destinationURL: URL,
              completion: ((Error?) -> Void)) {
        do {
            try fileManager.copyItem(at: fileSystemElement.url, to: destinationURL)
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    func move(_ fileSystemElement: FileSystemElement,
              toDestination destinationURL: URL,
              completion: ((Error?) -> Void)) {
        do {
            try fileManager.moveItem(at: fileSystemElement.url, to: destinationURL)
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    func delete(_ fileSystemElement: FileSystemElement, completion: ((Error?) -> Void)) {
        do {
            try fileManager.removeItem(at: fileSystemElement.url)
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    func rename(_ fileSystemElement: FileSystemElement, newFileName: String, completion: ((Error?) -> Void)) {
        let urlWithDroppedFileName = fileSystemElement.url.deletingLastPathComponent()
        let destinationURL = urlWithDroppedFileName.appendingPathComponent(newFileName)
        
        do {
            try fileManager.moveItem(at: fileSystemElement.url, to: destinationURL)
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
}
