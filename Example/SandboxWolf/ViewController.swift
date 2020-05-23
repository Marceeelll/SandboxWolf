//
//  ViewController.swift
//  SandboxManager
//
//  Created by Marcel on 05/23/2020.
//  Copyright (c) 2020 Marcel. All rights reserved.
//

import UIKit
import SandboxWolf

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction private func createExampleDataAction() {
        ExampleDataCreator.create10HelloWorldFilesInDocumentDirectory()
    }
    
    @IBAction private func openSandboxManagerAction() {
        let vctrl = SandboxManagerViewController(roots: [
            .sandbox,
            // Add your own app group identifier if you want to move
            // files between the sandbox and the app group
            // .appGroup(applicationGroupIdentifier: "your-appgroup-id")
            ]
        )
        self.present(vctrl, animated: true)
    }

}
