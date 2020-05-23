//
//  ErrorPresentable.swift
//  SandboxManager
//
//  Created by Marcel Hagmann on 23.05.20.
//  Copyright © 2020 Marcel Hagmann. All rights reserved.
//

import UIKit

protocol ErrorPresentable {
    func present(error: Error)
}

extension ErrorPresentable where Self: UIViewController {
    
    func present(error: Error) {
        let alert = UIAlertController(title: "Error occurred",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
}
