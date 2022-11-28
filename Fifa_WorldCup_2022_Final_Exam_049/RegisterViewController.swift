//
//  RegisterViewController.swift
//  Fifa_WorldCup_2022_Final_Exam_049
//
//  Created by Parinya Termkasipanich on 29/11/2565 BE.
//

import UIKit

class RegisterViewController: UIViewController {
    let database = UtilsDatabase()

    @IBOutlet weak var input_name: UITextField!
    @IBOutlet weak var input_username: UITextField!
    @IBOutlet weak var input_password: UITextField!
    
    @IBAction func btnSubmitRegister(_ sender: Any) {
        if input_name.text != "" && input_username.text != "" && input_password.text != "" {
            if !database.CheckIsMemberExist(username: input_username.text!) {
                let success = database.InsertRegisterMember(name: input_name.text!, username: input_username.text!, password: input_password.text!)
                if success {
                    customAlert(title: "Success", message: "You can Login", btn: "OK", method: "gotologin")
                }else{
                    customAlert(title: "Error", message: "Internal Error", btn: "OK", method: "")
                }
            }else{
                customAlert(title: "Error", message: "Username Exist in DB", btn: "OK", method: "")
            }
        }else{
            customAlert(title: "Error", message: "All Field are Required", btn: "OK", method: "")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnGotoLoginPage(_ sender: Any) {
        GotoLoginPage()
    }
    
    func GotoLoginPage() {
        guard let ModalVC = storyboard?.instantiateViewController(withIdentifier: "LoginViewController_ID") as? LoginViewController else {return}
        ModalVC.modalPresentationStyle = .fullScreen
        
        present(ModalVC, animated: true)
    }
    
    @IBAction func btnGotoStartPage(_ sender: Any) {
        guard let ModalVC = storyboard?.instantiateViewController(withIdentifier: "ViewController_ID") as? ViewController else {return}
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

extension RegisterViewController {
    func customAlert(title:String, message:String, btn:String, method:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: btn, style: .cancel, handler: {action in
            if method == "gotologin" {
                self.GotoLoginPage()
            }
            print("tap dismiss")
        }))
    
        present(alert, animated: true)
    }
}
