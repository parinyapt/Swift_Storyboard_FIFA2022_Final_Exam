//
//  Utils.PropertyList.swift
//  Fifa_WorldCup_2022_Final_Exam_049
//
//  Created by Parinya Termkasipanich on 28/11/2565 BE.
//

import Foundation

class UtilsPropertyList {
    var propertylist:Dictionary = [String:String]()
    
    var plistFilename:String = "flagImage"
    
    init() {
        propertylist.removeAll()
        
        do {
            let plistURL = Bundle.main.url(forResource: plistFilename, withExtension: "plist") ?? nil
            if plistURL != nil {
                let tempData = try Data(contentsOf: plistURL!)
                let myPlist = try PropertyListSerialization.propertyList(from: tempData, options: [], format: nil)
                propertylist = myPlist as! Dictionary
                print("=== Property List Setup Success ===")
            }else{
                print("X=== Property List File Not Found ===X")
                exit(0)
            }
        } catch {
            print("X=== Property List Setup Error ===X")
            exit(0)
        }
    }
    
    func GetFlagImage(code:String) -> String {
        if let image = propertylist[code] {
            return image
        }else{
            return propertylist["404"]!
        }
    }
}
