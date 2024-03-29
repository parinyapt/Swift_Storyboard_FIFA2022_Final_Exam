//
//  TeamDetailViewController.swift
//  Fifa_WorldCup_2022_Final_Exam_049
//
//  Created by Parinya Termkasipanich on 28/11/2565 BE.
//

import UIKit

class TeamDetailViewController: UIViewController {
    let database = UtilsDatabase()
    let plist = UtilsPropertyList()
    
    var team_select:String = ""

    @IBOutlet weak var flagImage: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var scoreMP: UILabel!
    @IBOutlet weak var scoreW: UILabel!
    @IBOutlet weak var scorel: UILabel!
    @IBOutlet weak var scorePTS: UILabel!
    @IBOutlet weak var scoreGF: UILabel!
    @IBOutlet weak var scoreGA: UILabel!
    @IBOutlet weak var scoreGD: UILabel!
    @IBOutlet weak var scoreD: UILabel!
    
    @IBOutlet weak var MatchTableView: UITableView!
    
    @IBOutlet weak var favbtn: UIButton!
    
    @IBAction func favbtn(_ sender: Any) {
        if UserDefaults.standard.value(forKey: "userid") != nil {
            let isfav = database.CheckIsFavorite(teamid:team_select,userid:UserDefaults.standard.value(forKey: "userid") as! String)
            if isfav {
                let success = database.UnFavorite(teamid: team_select, userid: UserDefaults.standard.value(forKey: "userid") as! String)
                if success {
                    print("UnFavorite complete")
                    database.TestShowAllFavorite()
//                    customAlert(title: "Success", message: "UnFavorite complete", btn: "OK", method: "gotofav")
                }else{
//                    customAlert(title: "Error", message: "UnFavorite Fail", btn: "OK", method: "")
                    print("UnFavorite Fail")
                    database.TestShowAllFavorite()
                }
            }else{
                let success = database.AddFavorite(teamid: team_select, userid: UserDefaults.standard.value(forKey: "userid") as! String)
                if success {
                    print("AddFavorite complete")
                    database.TestShowAllFavorite()
//                    customAlert(title: "Success", message: "AddFavorite complete", btn: "OK", method: "gotofav")
                }else{
                    print("AddFavorite Fail")
                    database.TestShowAllFavorite()
//                    customAlert(title: "Error", message: "UnFavorite Fail", btn: "OK", method: "")
                }
            }
            favbtn.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        database.GetTeamDetailByTeamID(team_id: team_select)
        database.GetAllMatchByTeamID(team_id: team_select)
        // Do any additional setup after loading the view.
        setup()
        
        MatchTableView.dataSource = self
        MatchTableView.delegate = self
        MatchTableView.rowHeight = 210
        
        if UserDefaults.standard.value(forKey: "userid") != nil {
            let isfav = database.CheckIsFavorite(teamid:team_select,userid:UserDefaults.standard.value(forKey: "userid") as! String)
            if isfav {
                favbtn.setImage(UIImage(systemName: "star.fill"), for: .normal)
            }else{
                favbtn.setImage(UIImage(systemName: "star"), for: .normal)
            }
            favbtn.isHidden = false
        }
    }
    
    func setup(){
        flagImage.image = UIImage(named: plist.GetFlagImage(code: database.dataFetchOne["fifa_code"] as! String))
        name.text = database.dataFetchOne["name"] as? String
        scoreMP.text = String(database.dataFetchOne["score_mp"] as! Int64)
        scoreW.text = String(database.dataFetchOne["score_w"] as! Int64)
        scorel.text = String(database.dataFetchOne["score_l"] as! Int64)
        scorePTS.text = String(database.dataFetchOne["score_pts"] as! Int64)
        scoreGF.text = String(database.dataFetchOne["score_gf"] as! Int64)
        scoreGA.text = String(database.dataFetchOne["score_ga"] as! Int64)
        scoreGD.text = String(database.dataFetchOne["score_gd"] as! Int64)
        scoreD.text = String(database.dataFetchOne["score_d"] as! Int64)
    }
    
    @IBAction func btnClosePage(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
//    func customAlert(title:String, message:String, btn:String, method:String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: btn, style: .cancel, handler: {action in
//            if method == "gotofav" {
////                self.GotoLoginPage()
//            }
//            print("tap dismiss")
//        }))
//
//        present(alert, animated: true)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TeamDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return database.dataFetchArray.count
    }
}

extension TeamDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MatchTableView.dequeueReusableCell(withIdentifier: "MatchDetailTableViewCell_ID", for: indexPath) as! MatchDetailTableViewCell
        
        cell.selectionStyle = .none
        cell.config(
            gdatetime: database.dataFetchArray[indexPath.item]["local_date"] as! String,
            gaway_team_img: plist.GetFlagImage(code:  database.dataFetchArray[indexPath.item]["away_flag"] as! String),
            gaway_team_name: database.dataFetchArray[indexPath.item]["away_team_name"] as! String,
            gaway_team_score: database.dataFetchArray[indexPath.item]["away_score"] as! String,
            ghome_team_img:plist.GetFlagImage(code:  database.dataFetchArray[indexPath.item]["home_flag"] as! String),
            ghome_team_name: database.dataFetchArray[indexPath.item]["home_team_name"] as! String,
            ghome_team_score: database.dataFetchArray[indexPath.item]["home_score"] as! String,
            gaway_scorer: database.dataFetchArray[indexPath.item]["away_score_player"] as! String,
            ghome_scorer: database.dataFetchArray[indexPath.item]["home_score_player"] as! String
        )

        return cell
    }
}
