//
//  LoginViewController.swift
//  LoginController
//
//  Created by Musale, Ashish on 7/17/17.
//  Copyright © 2017 Ashish Musale. All rights reserved.
//

import UIKit

public protocol LoginViewControllerDelegate: class {
    /**
     Delegate method to call when signin is clicked
     */
    func signin(loginViewController: LoginViewController)
    
}

open class LoginViewController: UIViewController, UITextFieldDelegate {

    public weak var delegate: LoginViewControllerDelegate?
    public var username: UITextField!
    public var password: UITextField!
    var signinButton: UIButton!
    var errText: UITextView!
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addTextFields()
        addSigninButton()
        self.hideKeyboardWhenTappedAround()
        
    }
    
    /**
     Set the background color for the view
     */
    public var backgroundColor: UIColor = UIColor.white {
        didSet {
            self.view.backgroundColor = backgroundColor;
        }
    }
    
    /**
     add the logo for your company/product on the login screen
     */
    public func addLogo(imgName: String, width: Int, height: Int) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        let image = UIImage(named: imgName);
        imageView.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/6)
        imageView.image = image;
        self.view.addSubview(imageView);
    }
    
    /**
     Add the username and password text fields on the screen
     */
    fileprivate func addTextFields() {
        username = UITextField(frame: CGRect(x: 50, y: (self.view.frame.height-200)/2 - 30, width: self.view.frame.width - 100, height: 48))
        username.borderStyle = .roundedRect
        username.placeholder = "Username"
        username.spellCheckingType = .no
        username.becomeFirstResponder()
        username.returnKeyType = .next
        username.delegate = self
        self.view.addSubview(username)
        
        password = UITextField(frame: CGRect(x: 50, y: (self.view.frame.height-200)/2 + 30, width: self.view.frame.width - 100, height: 48))
        password.isSecureTextEntry = true
        password.placeholder = "Password"
        password.borderStyle = .roundedRect
        password.spellCheckingType = .no
        password.delegate = self
        password.returnKeyType = .done
        self.view.addSubview(password)
        
    }
    
    /**
     Add the signin button on screen at the bottom of the page
     TODO: maybe show this as a button somewhere else on the screen or move the page up to show
     the signin button just above the keyboard
     */
    fileprivate func addSigninButton() {
        signinButton = UIButton(type: .system)
        signinButton.frame = CGRect(x: 0, y: self.view.frame.height - 64, width: self.view.frame.width, height: 64)
        signinButton.setTitle("Sign In", for: .normal)
        signinButton.setTitleColor(.white, for: .normal)
        signinButton.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        signinButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        signinButton.layer.cornerRadius = 0
        signinButton.layer.masksToBounds = true
        signinButton.addTarget(self, action: #selector(signin_clicked), for: .touchUpInside)
        self.view.addSubview(signinButton)
        
    }
    
    /**
     call the delegate method when the signin button is clicked
     */
    @objc fileprivate func signin_clicked() {
        self.delegate?.signin(loginViewController: self)
    }
    
    /**
     Define the behavior when the return button is clicked when on username field or password field
     */
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == username {
            password.becomeFirstResponder()
        }
        else {
            self.view.endEditing(true)
            signin_clicked()
        }
        return false
    }
}

/**
 Extension to allow us to dismiss the keyboard when clicked somewhere else on the screen except the
 text fields
 */
extension LoginViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
