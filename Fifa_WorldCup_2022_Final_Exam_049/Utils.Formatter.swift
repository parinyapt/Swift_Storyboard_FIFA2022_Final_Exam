//
//  Utils.Formatter.swift
//  Fifa_WorldCup_2022_Final_Exam_049
//
//  Created by Parinya Termkasipanich on 28/11/2565 BE.
//

import Foundation
import UIKit

class UtilsFormatter {
    func DatetoString(date: String) -> String {
        print(date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:00"
        let dateforprocess = dateFormatter.date(from:date)!
        dateFormatter.locale = Locale(identifier:"en_US")
        dateFormatter.dateFormat = "dd MMM yyyy  HH:mm"
        return dateFormatter.string(from: dateforprocess)
    }
    
    func stringToDate(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: date)!
    }
    
}
