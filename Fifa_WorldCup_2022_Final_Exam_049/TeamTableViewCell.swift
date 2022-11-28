//
//  TeamTableViewCell.swift
//  Fifa_WorldCup_2022_Final_Exam_049
//
//  Created by Parinya Termkasipanich on 28/11/2565 BE.
//

import UIKit

class TeamTableViewCell: UITableViewCell {

    @IBOutlet weak var flagimage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var scoreMP: UILabel!
    @IBOutlet weak var scoreW: UILabel!
    @IBOutlet weak var scorel: UILabel!
    @IBOutlet weak var scorePTS: UILabel!
    @IBOutlet weak var scoreGF: UILabel!
    @IBOutlet weak var scoreGA: UILabel!
    @IBOutlet weak var scoreGD: UILabel!
    @IBOutlet weak var scoreD: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(flagimg:String,gname:String,gscoreMP:String,gscoreW:String,gscorel:String,gscorePTS:String,gscoreGF:String,gscoreGA:String,gscoreGD:String,gscoreD:String) {
        flagimage.image = UIImage(named: flagimg)
        name.text = gname
        scoreMP.text = gscoreMP
        scoreW.text = gscoreW
        scorel.text = gscorel
        scorePTS.text = gscorePTS
        scoreGF.text = gscoreGF
        scoreGA.text = gscoreGA
        scoreGD.text = gscoreGD
        scoreD.text = gscoreD
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
