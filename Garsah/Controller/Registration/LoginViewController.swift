//
//  LoginViewController.swift
//  Garsah
//
//  Created by Norah Almaneea on 20/05/2022.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUp()
    }
    func SetUp(){
        //Hide Error Label and activityInd
        errorLabel.alpha = 0
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        //Style Elements
        TextField.styleTextField(emailTextField)
        TextField.styleTextField(passwordTextField)
        TextField.styleButton(loginButton)
    }
    
    //MARK: - TextField Function
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField{
            passwordTextField.becomeFirstResponder()
        }
        else{
            view.endEditing(true)
        }
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    


}
