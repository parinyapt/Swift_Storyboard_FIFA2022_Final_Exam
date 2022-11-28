//
//  utils.database.swift
//  Fifa_WorldCup_2022_Final_Exam_049
//
//  Created by Parinya Termkasipanich on 28/11/2565 BE.
//

import Foundation
import GRDB

class UtilsDatabase{
    //setup
    var dbQueue: DatabaseQueue!
    var config = Configuration()

    var dataFetchOne:[String:Any] = [:]
    var dataFetchArray:[[String:Any]] = [[String:Any]]()
    
    var databaseName:String = "fifa2022"
    
    init() {
        dataFetchOne.removeAll()
        dataFetchArray.removeAll()
        
        do {
            let databaseURL = Bundle.main.path(forResource: databaseName, ofType: "sqlite") ?? nil
            if databaseURL != nil {
                print("=== Database Path Found ===\n@Path : \(databaseURL!)")
                dbQueue = try DatabaseQueue(path: databaseURL!, configuration: config)
                print("=== Database Setup Success ===")
            }else{
                print("X=== Database Path Not Found ===X")
                exit(0)
            }
        } catch {
            print("X=== Database Setup Error ===X")
            exit(0)
        }
    }
    
    
    func GetAllTeam() {
        do {
            try dbQueue.read { db in
                let sqlCommand = "SELECT id, uuid, name, groups, fifa_code, iso2 FROM team"
                let rows = try Row.fetchCursor(db, sql: sqlCommand)
                while let row = try rows.next() {
                    let tempData:[String:String] = [
                        "id": row["id"],
                        "uuid": row["uuid"],
                        "name": row["name"],
                        "groups": row["groups"],
                        "fifa_code": row["fifa_code"],
                        "iso2": row["iso2"]
                    ]
                    dataFetchArray.append(tempData)
                }
                print(dataFetchArray)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
   
}

