//
//  ViewController.swift
//  LoginController
//
//  Created by Musale, Ashish on 07/18/2017.
//  Copyright (c) 2017 Musale, Ashish. All rights reserved.
//

import UIKit
import LoginController

class ViewController: UIViewController, LoginViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        let loginController = LoginViewController()
        loginController.backgroundColor = UIColor.white
        loginController.delegate = self
        loginController.password = UITextField()
        loginController.username.placeholder = "username override"
        self.present(loginController, animated: true, completion: nil)
    }
    
    func signin(loginViewController: LoginViewController) {
        print ("delegate called successfully")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

