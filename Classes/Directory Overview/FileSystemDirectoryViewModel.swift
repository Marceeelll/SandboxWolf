//
//  FileSystemDirectoryViewModel.swift
//  SandboxManager
//
//  Created by Marcel Hagmann on 22.05.20.
//  Copyright © 2020 Marcel Hagmann. All rights reserved.
//

import UIKit

protocol FileSystemDirectoryViewModelDelegate: FileSystemElementPresentable, ErrorPresentable {
    func presentFileSystemElementOptionMenu(_ optionMenu: UIViewController)
    func presentRenameDialog(_ viewController: UIViewController)
}

class FileSystemDirectoryViewModel {
    
    public weak var delegate: FileSystemDirectoryViewModelDelegate?
    
    private let fileSystemManager: FileSystemManager
    private let fileSystemURL: URL
    
    @Published private(set) var fileSystemElements = [FileSystemElement]()
    
    init(fileSystemURL: URL) {
        self.fileSystemManager = FileSystemManager.shared
        self.fileSystemURL = fileSystemURL
    }
    
    // MARK: - Input
    
    func didSelect(index: Int) {
        let fileSystemElement = fileSystemElements[index]
        
        if fileSystemElement is Directory {
            delegate?.present(fileSystemElement: fileSystemElement)
        } else {
            let optionMenu = createOptionMenu(for: fileSystemElement)
            delegate?.presentFileSystemElementOptionMenu(optionMenu)
        }
    }
    
    func didDelete(index: Int) {
        let fileSystemElement = fileSystemElements[index]
        
        delete(fileSystemElement: fileSystemElement)
    }
    
    func didTapCopyToThisLocation() {
        guard let fileSystemElementToCopy = FileSystemElementClipboard.shared.fileSystemElement else { return }
        let destination = fileSystemURL.appendingPathComponent(fileSystemElementToCopy.fileName)
        
        fileSystemManager.copy(fileSystemElementToCopy, toDestination: destination) { [weak self] error in
            
            FileSystemElementClipboard.shared.fileSystemElement = nil
            
            if let error = error {
                self?.delegate?.present(error: error)
            } else {
                loadFileSystemElements()
            }
        }
    }
    
    func didTapMoveToThisLocation() {
        guard let fileSystemElementToMove = FileSystemElementClipboard.shared.fileSystemElement else { return }
        let destination = fileSystemURL.appendingPathComponent(fileSystemElementToMove.fileName)
        
        fileSystemManager.move(fileSystemElementToMove, toDestination: destination) { [weak self] error in
            
            FileSystemElementClipboard.shared.fileSystemElement = nil
            
            if let error = error {
                self?.delegate?.present(error: error)
            } else {
                loadFileSystemElements()
            }
        }
    }
    
    // MARK: - Logic - Load / Remove
    
    func loadFileSystemElements() {
        self.fileSystemElements = fileSystemManager.contentsOf(url: fileSystemURL)
    }
    
    private func delete(fileSystemElement: FileSystemElement) {
        fileSystemManager.delete(fileSystemElement) { error in
            
            if let error = error {
                delegate?.present(error: error)
            } else {
                loadFileSystemElements()
            }
        }
    }
    
    // MARK: - Presenting
    
    private func createOptionMenu(for fileSystemElement: FileSystemElement) -> UIAlertController {
        let actionSheet = UIAlertController(title: fileSystemElement.fileName,
                                            message: nil,
                                            preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        let renameAction = UIAlertAction(title: "Rename File", style: .default) { [weak self] alertAction in
            guard let self = self else { return }
            let renameDialogViewController = self.createRenameAlert(for: fileSystemElement)
            self.delegate?.presentRenameDialog(renameDialogViewController)
        }
        let clipboardAction = UIAlertAction(title: "Copy to Clipboard", style: .default) { _ in
            FileSystemElementClipboard.shared.fileSystemElement = fileSystemElement
        }
        let deleteAction = UIAlertAction(title: "Delete File", style: .destructive) { [weak self] _ in
            self?.delete(fileSystemElement: fileSystemElement)
        }
        
        actionSheet.addAction(cancelAction)
        actionSheet.addAction(renameAction)
        actionSheet.addAction(clipboardAction)
        actionSheet.addAction(deleteAction)
        
        return actionSheet
    }
    
    private func createRenameAlert(for fileSystemElement: FileSystemElement) -> UIAlertController {
        let alert = UIAlertController(title: fileSystemElement.fileName, message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        let renameAction = UIAlertAction(title: "Rename", style: .destructive) { [weak self] _ in
            guard let newFileName = alert.textFields?.first?.text else { return }
            
            self?.fileSystemManager.rename(fileSystemElement, newFileName: newFileName) { [weak self] error in
                
                if let error = error {
                    self?.delegate?.present(error: error)
                } else {
                    self?.loadFileSystemElements()
                }
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(renameAction)
        
        return alert
    }
    
}
