//
//  SignUpViewController.swift
//  Garsah
//
//  Created by Norah Almaneea on 20/05/2022.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUp()
        // Do any additional setup after loading the view.
    }
    func SetUp(){
        //Hide Error Label and activityInd
        errorLabel.alpha = 0
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        //Style Elements
        TextField.styleTextField(nameTextField)
        TextField.styleTextField(emailTextField)
        TextField.styleTextField(passwordTextField)
        TextField.styleButton(signupButton)
    }
    
    //MARK: - TextField Function
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField{
            emailTextField.becomeFirstResponder()
        }else if textField == emailTextField{
            passwordTextField.becomeFirstResponder()
        }else{
            view.endEditing(true)
        }
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
