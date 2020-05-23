//
//  SandboxManagerViewController.swift
//  SandboxManager
//
//  Created by Marcel Hagmann on 22.05.20.
//  Copyright © 2020 Marcel Hagmann. All rights reserved.
//

import UIKit

public class SandboxManagerViewController: UINavigationController {
    
    public init(roots: [Root]) {
        super.init(nibName: nil, bundle: nil)
        let rootURLs = roots.map { $0.fileSystemURL }
        let vctrl = FileSystemRootViewController(rootURLs: rootURLs)
        pushViewController(vctrl, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public enum Root {
        case sandbox
        case appGroup(applicationGroupIdentifier: String)
        
        var fileSystemURL: URL {
            switch self {
            case .sandbox:
                let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                let documentsDirectory = paths[0].deletingLastPathComponent()
                return documentsDirectory
            case .appGroup(let applicationGroupIdentifier):
                // It is the responsibility of the developer that the inserted app group identifier is an existing one!
                return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: applicationGroupIdentifier)!
            }
        }
    }
    
}
