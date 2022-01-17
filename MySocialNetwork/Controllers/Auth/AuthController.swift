//
//  AuthController.swift
//  MySocialNetwork
//
//  Created by Roberto Antonio on 08/01/22.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore


class AuthController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    @IBOutlet weak var fullNameText: UITextField!
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var btnSignIn: UIButton!
    
    private let storage = Storage.storage().reference()
    
    private var imageData : Data!
    
    private let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        self.contentView.addGestureRecognizer(tap)
        
        self.fullNameText.setBottomBorder()
        self.emailText.setBottomBorder()
        self.passwordText.setBottomBorder()
        
        let attributedText = NSMutableAttributedString(string: "Already have an account? Sign In", attributes: [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 12.0)!, NSAttributedString.Key.foregroundColor : UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)])
        
        attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 215/255.0, green: 81/255.0, blue: 108/255.0, alpha: 1.0), range: NSRange(location: 25, length: 7))
        
        self.btnSignIn.setAttributedTitle(attributedText, for: .normal)
    }


    @IBAction func signUpAction(_ sender: Any) {
        
        self.view.endEditing(true)
        
//        let chartsController = ChartsController(nibName: "ChartsController", bundle: .main)
        
//        let viewModel = ChartsViewModel()
//        chartsController.viewModel = viewModel
//
//        self.navigationController?.pushViewController(chartsController, animated: true)
        
        
        if let imageData = self.imageData, let name = fullNameText.text, let email = emailText.text, let password = passwordText.text {
            Auth.auth().createUser(withEmail: email, password: password) { [self] (result, error) in
                if let result = result, error == nil {

//                    let homeController = HomeController(nibName: "HomeController", bundle: .main)
//
//
//                    self.navigationController?.pushViewController(homeController, animated: true)
                    
                    if let imageData = self.imageData {
                        storage.child("images/\(name)").putData(imageData, metadata: nil) { _, error in
                            guard  error == nil else {
                                print("Failed to upload")
                                return
                            }
                        }
                    }
                    
                    db.collection("users").document(email).setData(["name" : name])
                    

                    let alertController = UIAlertController(title: "Usuario registrado", message: "Tu usuario ha sido registrado, ahora puedes loguearte en la app", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))

                    self.present(alertController, animated: true, completion: nil)
                    

                } else {
                    let alertController = UIAlertController(title: "Error", message: "Se ha producido un error al registrar el usuario", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))

                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    @IBAction func tapButtonSignIn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addSelfieAction(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let imagePickerController = UIImagePickerController()
//            imagePickerController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePickerController.allowsEditing = true
            imagePickerController.delegate = self
            
            imagePickerController.sourceType = .camera
            
            
            imagePickerController.cameraDevice = .front
            
            
            imagePickerController.modalPresentationStyle = .popover
            
            self.present(imagePickerController, animated: true, completion: nil)
            
        }
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AuthController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        dismiss(animated: true, completion: nil)
        
        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        guard let imageData = pickedImage?.pngData() else {
            return
        }
        
        let newSize = CGSize(width: (pickedImage?.size.width)! * 0.80, height: (pickedImage?.size.height)! * 0.80)
        UIGraphicsBeginImageContext(newSize)

        pickedImage?.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        

        UIGraphicsEndImageContext()
        
        self.imageData = newImage?.pngData()
        
//        self.profileImageView.image = UIImage(data: self.imageData)?.fixOrientation()
        self.profileImageView.image = newImage
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension AuthController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.fullNameText {
            emailText.becomeFirstResponder()
        } else if textField == self.emailText {
            passwordText.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
}


extension UIImage {
    // Repair Picture Rotation
    func fixOrientation() -> UIImage {
        if self.imageOrientation == .up {
            return self
        }
        
        var transform = CGAffineTransform.identity
        
        switch self.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: .pi)
            break
            
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.rotated(by: .pi / 2)
            break
            
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: self.size.height)
            transform = transform.rotated(by: -.pi / 2)
            break
            
        default:
            break
        }
        
        switch self.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            break
            
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: self.size.height, y: 0);
            transform = transform.scaledBy(x: -1, y: 1)
            break
            
        default:
            break
        }
        
        let ctx = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0, space: self.cgImage!.colorSpace!, bitmapInfo: self.cgImage!.bitmapInfo.rawValue)
        ctx?.concatenate(transform)
        
        switch self.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx?.draw(self.cgImage!, in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(size.height), height: CGFloat(size.width)))
            break
            
        default:
            ctx?.draw(self.cgImage!, in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(size.width), height: CGFloat(size.height)))
            break
        }
        
        let cgimg: CGImage = (ctx?.makeImage())!
        let img = UIImage(cgImage: cgimg)
        
        return img
    }
}
