//
//  LoginViewController.swift
//  Fifa_WorldCup_2022_Final_Exam_049
//
//  Created by Parinya Termkasipanich on 29/11/2565 BE.
//

import UIKit

class LoginViewController: UIViewController {
    let database = UtilsDatabase()

    @IBOutlet weak var input_username: UITextField!
    @IBOutlet weak var input_password: UITextField!
    
    @IBAction func btnSubmitLogin(_ sender: Any) {
        if input_username.text != "" && input_password.text != "" {
            let success = database.CheckLoginMember(username: input_username.text!, password: input_password.text!)
            if success {
                UserDefaults.standard.set(database.dataFetchArray[0]["id"], forKey: "userid")
                UserDefaults.standard.set(database.dataFetchArray[0]["name"], forKey: "username")
                customAlert(title: "Success", message: "Welcome \(database.dataFetchArray[0]["name"]!)", btn: "OK", method: "gotogrouppage")
            }else{
                customAlert(title: "Error", message: "username or password incorrect", btn: "OK", method: "")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnGotoRegisterPage(_ sender: Any) {
        guard let ModalVC = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController_ID") as? RegisterViewController else {return}
        ModalVC.modalPresentationStyle = .fullScreen
        
        present(ModalVC, animated: true)
    }
    
    @IBAction func btnGotoStartPage(_ sender: Any) {
        guard let ModalVC = storyboard?.instantiateViewController(withIdentifier: "ViewController_ID") as? ViewController else {return}
        ModalVC.modalPresentationStyle = .fullScreen
        
        present(ModalVC, animated: true)
    }
    
    func GotoGroupPage() {
        guard let ModalVC = storyboard?.instantiateViewController(withIdentifier: "GroupListViewController_ID") as? GroupListViewController else {return}
        ModalVC.modalPresentationStyle = .fullScreen
        
        present(ModalVC, animated: true)
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

extension LoginViewController {
    func customAlert(title:String, message:String, btn:String, method:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: btn, style: .cancel, handler: {action in
            if method == "gotogrouppage" {
                self.GotoGroupPage()
            }
            print("tap dismiss")
        }))
    
        present(alert, animated: true)
    }
}
