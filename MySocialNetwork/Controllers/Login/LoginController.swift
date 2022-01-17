//
//  LoginController.swift
//  MySocialNetwork
//
//  Created by Roberto Antonio on 10/01/22.
//

import UIKit
import FirebaseAuth

extension UITextField {
    
    
    func setBottomBorder(){
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)
            borderStyle = .none
                
            self.addSubview(bottomLine)
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        
        bottomLine.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        bottomLine.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        bottomLine.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        bottomLine.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1.0).isActive = true
        

    }
}


class LoginController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var textFieldEmail: UITextField!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBOutlet weak var btnSignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        
        let attributedText = NSMutableAttributedString(string: "New to Friendly Desi? Sign Up", attributes: [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 12.0)!, NSAttributedString.Key.foregroundColor : UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)])
        
        attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 215/255.0, green: 81/255.0, blue: 108/255.0, alpha: 1.0), range: NSRange(location: 22, length: 7))
        
        self.btnSignUp.setAttributedTitle(attributedText, for: .normal)
        
        self.contentView.addGestureRecognizer(tap)
        
        
    }


    @IBAction func actionSignIn(_ sender: Any) {
        
        if let email = self.textFieldEmail.text, let password = self.textFieldPassword.text {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                
                if let result = result, error == nil {
                    
                    let customTabBarController = CustomTabBarController()
                    
                    customTabBarController.setupView()
                    
//                    let navController = UINavigationController(rootViewController: customTabBarController)
//
//                    navController.modalPresentationStyle = .fullScreen
                    
                    customTabBarController.modalPresentationStyle = .fullScreen
                    
                    self.present(customTabBarController, animated: true, completion: nil)
                                        
                } else {
                    let alertController = UIAlertController(title: "Error", message: "Se ha producido un error al registrar el usuario", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))

                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }

    }
    
    @IBAction func signUp(_ sender: Any) {
        let authController = AuthController(nibName: "AuthController", bundle: .main)
    
        let navController = UINavigationController(rootViewController: authController)
        
        navController.modalPresentationStyle = .fullScreen
        
//        self.navigationController?.pushViewController(navController, animated: true)
        self.present(navController, animated: true, completion: nil)
    }
    
    @objc func dissmissKeyboard()  {
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: Notifications
    @objc func handleKeyboardNotification(notification:NSNotification){
                    
    //        print("Keyboard will show")
            
        if let userInfo = notification.userInfo {
                        
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
                
                
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
                           
//            buttonLoginBottomConstraint?.constant = isKeyboardShowing ? -keyboardFrame.height : 0
                
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: (keyboardFrame.size.height) + 10, right: 0)

            scrollView.contentInset = contentInsets
                
    //            buttonLoginBottomConstraint.constant = -keyboardFrame.height
                                            
        }
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.textFieldEmail.setBottomBorder()
        self.textFieldPassword.setBottomBorder()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LoginController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == textFieldEmail {
            textFieldPassword.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        
        return true
    }
}
