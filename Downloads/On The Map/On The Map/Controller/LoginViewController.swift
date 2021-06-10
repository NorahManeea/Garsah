//
//  LoginViewController.swift
//  On The Map
//
//  Created by Norah Almaneea on 27/01/2021.
//


import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setUPButton(loginButton)
        emailTextField.text = ""
        passwordTextField.text = ""
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
 
    //Dismiss Keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    @IBAction func signUpPressed(_ sender: Any) {
        if let url = URL(string: "https://auth.udacity.com/sign-up"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    @IBAction func loginButtonTapped(_ sender: Any) {
        setLoggingIn(true)
        UdacityClient.postSession(username: emailTextField.text ?? "", password: passwordTextField.text ?? "") { (success, error) in
            if success {
                print("successfully logged in")
                self.performSegue(withIdentifier: "COMPLETED", sender: nil)
                self.setLoggingIn(false)
            } else {
                self.showLoginFailure(message: error?.localizedDescription ?? "Unknown Error")
            }
        }
    }
    
    func setLoggingIn(_ loggingIn: Bool) {
        if loggingIn {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        emailTextField.isEnabled = !loggingIn
        passwordTextField.isEnabled = !loggingIn
        loginButton.isEnabled = !loggingIn
        signUpButton.isEnabled = !loggingIn
    }
    
    func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Check your Email or Password", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default) { action in
            self.setLoggingIn(false)
        })
        show(alertVC, sender: nil)
    }
    
}
