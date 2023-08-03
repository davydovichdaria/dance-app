import UIKit

class Storage {
    var login: String
    var password: String
    
    init(login: String, password: String) {
        self.login = login
        self.password = password
    }
}

class AuthorizationScreenVC: UIViewController {
    
    var storage = Storage.init(login: "", password: "")
    
    var status = ""
    
    var authorizationView: AuthorizationScreenView {
        return self.view as! AuthorizationScreenView
    }
    
    override func loadView() {
        self.view = AuthorizationScreenView(frame: Screen.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authorizationView.loginTextField.delegate = self
        authorizationView.passwordTextField.delegate = self
    
        authorizationView.onRegisterButtonTapped = {
            do {
                let status = try KeychainManager.save(
                    password: self.storage.password.data(using: .utf8) ?? Data(),
                    account: self.storage.login)
            } catch {
                print(error)
            }
        }
        
        authorizationView.onEnterButtonTapped = {
            do {
                
                if self.storage.login == "" || self.storage.password == "" {
                    print("No login or password")
                    throw KeychainManager.KeychainError.itemNotFound
                }
                
                let data = try KeychainManager.getPassword(for: self.storage.login)
                
                let password = String(decoding: data ?? Data(),
                                      as: UTF8.self)
                
                if password == self.storage.password {
                    self.showMainScreen()
                } else {
                    print("Incorrect password")
                    self.authorizationView.errorLabel.isHidden = false
                }
                
            } catch {
                print("This user isn't exist")
                self.authorizationView.errorLabel.isHidden = false
            }
        }
    }
    
    func showMainScreen() {
        let rootVC = Di.shared.screenFactory.makeMainTabVC()
        sceneDelegate?.window?.rootViewController = rootVC
    }
    
}

extension AuthorizationScreenVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == authorizationView.loginTextField {
            authorizationView.passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == authorizationView.loginTextField  {
            self.storage.login = textField.text!
        } else {
            self.storage.password = textField.text!
        }
    }
}


