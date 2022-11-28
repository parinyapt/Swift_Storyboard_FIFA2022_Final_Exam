//
//  GroupListViewController.swift
//  Fifa_WorldCup_2022_Final_Exam_049
//
//  Created by Parinya Termkasipanich on 28/11/2565 BE.
//

import UIKit

class GroupListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnGroupA(_ sender: Any) {
        chooseGroupAction(group: "A")
    }
    
    @IBAction func btnGroupB(_ sender: Any) {
        chooseGroupAction(group: "B")
    }
    
    @IBAction func btnGroupC(_ sender: Any) {
        chooseGroupAction(group: "C")
    }
    
    @IBAction func btnGroupD(_ sender: Any) {
        chooseGroupAction(group: "D")
    }
    
    @IBAction func btnGroupE(_ sender: Any) {
        chooseGroupAction(group: "E")
    }
    
    @IBAction func btnGroupF(_ sender: Any) {
        chooseGroupAction(group: "F")
    }
    
    @IBAction func btnGroupG(_ sender: Any) {
        chooseGroupAction(group: "G")
    }
    
    @IBAction func btnGroupH(_ sender: Any) {
        chooseGroupAction(group: "H")
    }
    
    func chooseGroupAction(group:String) {
        guard let ModalVC = storyboard?.instantiateViewController(withIdentifier: "TeamListTableViewController_ID") as? TeamListTableViewController else {return}
        ModalVC.modalPresentationStyle = .popover
        ModalVC.group_select = group
        
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
