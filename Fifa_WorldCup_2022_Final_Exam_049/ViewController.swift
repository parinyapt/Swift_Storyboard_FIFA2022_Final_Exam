//
//  ViewController.swift
//  Fifa_WorldCup_2022_Final_Exam_049
//
//  Created by Parinya Termkasipanich on 28/11/2565 BE.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        UserDefaults.standard.removeObject(forKey: "userid")
        UserDefaults.standard.removeObject(forKey: "username")
    }

    @IBAction func btnStart(_ sender: Any) {
        guard let ModalVC = storyboard?.instantiateViewController(withIdentifier: "GroupListViewController_ID") as? GroupListViewController else {return}
        ModalVC.modalPresentationStyle = .fullScreen
        
        present(ModalVC, animated: true)
    }
    
    @IBAction func btnGotoLoginPage(_ sender: Any) {
        guard let ModalVC = storyboard?.instantiateViewController(withIdentifier: "LoginViewController_ID") as? LoginViewController else {return}
        ModalVC.modalPresentationStyle = .fullScreen
        
        present(ModalVC, animated: true)
    }
}

