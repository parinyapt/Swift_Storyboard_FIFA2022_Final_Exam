//
//  TeamListTableViewController.swift
//  Fifa_WorldCup_2022_Final_Exam_049
//
//  Created by Parinya Termkasipanich on 28/11/2565 BE.
//

import UIKit

class TeamListTableViewController: UITableViewController {
    let database = UtilsDatabase()
    let plist = UtilsPropertyList()
    
    var group_select:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        database.GetAllTeamByGroup(group: group_select)

        self.tableView.backgroundView = UIImageView(image: UIImage(named: "bg1.png"))
        self.tableView.rowHeight = 200
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return database.dataFetchArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamTableViewCell_ID", for: indexPath) as! TeamTableViewCell
        
        cell.setup(
            flagimg: plist.GetFlagImage(code: database.dataFetchArray[indexPath.item]["fifa_code"] as! String),
            gname: database.dataFetchArray[indexPath.item]["name"] as! String,
            gscoreMP: database.dataFetchArray[indexPath.item]["score_mp"] as! String,
            gscoreW: database.dataFetchArray[indexPath.item]["score_w"] as! String,
            gscorel: database.dataFetchArray[indexPath.item]["score_l"] as! String,
            gscorePTS: database.dataFetchArray[indexPath.item]["score_pts"] as! String,
            gscoreGF: database.dataFetchArray[indexPath.item]["score_gf"] as! String,
            gscoreGA: database.dataFetchArray[indexPath.item]["score_ga"] as! String,
            gscoreGD: database.dataFetchArray[indexPath.item]["score_gd"] as! String,
            gscoreD: database.dataFetchArray[indexPath.item]["score_d"] as! String
        )

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.item)
        guard let ModalVC = storyboard?.instantiateViewController(withIdentifier: "TeamDetailViewController_ID") as? TeamDetailViewController else {return}
        ModalVC.modalPresentationStyle = .fullScreen
        ModalVC.team_select = database.dataFetchArray[indexPath.item]["id"] as! String
        
        present(ModalVC, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//func customAlert(view: UIViewController, title:String, message:String, btn:String) {
//    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
//    alert.addAction(UIAlertAction(title: btn, style: .cancel, handler: {action in
//        print("tap dismiss")
////            self.navigationController?.popViewController(animated: true)
//    }))
//
//    view.present(alert, animated: true)
//}
