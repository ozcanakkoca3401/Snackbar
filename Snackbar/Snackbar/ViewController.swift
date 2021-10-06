//
//  ViewController.swift
//  Snackbar
//
//  Created by Ozcan Akkoca on 6.10.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showSnackBarAction(_ sender: Any) {
        self.showSnackBar(success: true, message: "Hello World!")
    }
    
}

