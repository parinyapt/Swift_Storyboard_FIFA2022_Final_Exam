//
//  MatchDetailTableViewCell.swift
//  Fifa_WorldCup_2022_Final_Exam_049
//
//  Created by Parinya Termkasipanich on 28/11/2565 BE.
//

import UIKit

class MatchDetailTableViewCell: UITableViewCell {
    
    let formatter = UtilsFormatter()

    @IBOutlet weak var datetime: UILabel!
    @IBOutlet weak var away_team_img: UIImageView!
    @IBOutlet weak var away_team_name: UILabel!
    @IBOutlet weak var away_team_score: UILabel!
    @IBOutlet weak var away_scorer: UITextView!
    
    @IBOutlet weak var home_team_img: UIImageView!
    @IBOutlet weak var home_team_name: UILabel!
    @IBOutlet weak var home_team_score: UILabel!
    @IBOutlet weak var home_scorer: UITextView!
    
    @IBOutlet weak var away_win_icon: UIImageView!
    @IBOutlet weak var home_win_icon: UIImageView!
    
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var labelColon: UILabel!
    @IBOutlet weak var labelScorer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(gdatetime:String,gaway_team_img:String,gaway_team_name:String,gaway_team_score:String,ghome_team_img:String,ghome_team_name:String,ghome_team_score:String,gaway_scorer:String,ghome_scorer:String) {
        datetime.text = formatter.DatetoString(date: gdatetime)
        away_team_img.image = UIImage(named: gaway_team_img)
        away_team_name.text = gaway_team_name
        home_team_img.image = UIImage(named: ghome_team_img)
        home_team_name.text = ghome_team_name
        if Date() < formatter.stringToDate(date: gdatetime) {
            status.isHidden = false
            labelColon.isHidden = true
            labelScorer.isHidden = true
            away_team_score.isHidden = true
            home_team_score.isHidden = true
            away_scorer.isHidden = true
            home_scorer.isHidden = true
        }else{
            status.isHidden = true
            away_team_score.text = gaway_team_score
            home_team_score.text = ghome_team_score
            if Int(gaway_team_score)! > Int(ghome_team_score)! {
                away_win_icon.isHidden = false
                home_win_icon.isHidden = true
            }else if Int(ghome_team_score)! > Int(gaway_team_score)! {
                away_win_icon.isHidden = true
                home_win_icon.isHidden = false
            }else{
                away_win_icon.isHidden = true
                home_win_icon.isHidden = true
            }
            
            away_scorer.text = gaway_scorer.replacingOccurrences(of: ",", with: "\n")
            home_scorer.text = ghome_scorer.replacingOccurrences(of: ",", with: "\n")
            
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
