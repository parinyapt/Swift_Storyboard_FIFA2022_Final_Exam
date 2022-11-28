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
    
    var favdataFetchArray:[[String:Any]] = [[String:Any]]()
    
    var databaseName:String = "fifa2022new"
    
    init() {
        dataFetchOne.removeAll()
        dataFetchArray.removeAll()
        favdataFetchArray.removeAll()
        
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
    
    
    func GetAllTeamByGroup(group:String) {
        do {
            try dbQueue.read { db in
                let sqlCommand = "SELECT team.id AS id, team.uuid AS uuid, name, fifa_code, iso2,score_mp, score_w, score_l, score_pts, score_gf, score_ga, score_gd, score_d FROM team INNER JOIN standing ON team.id = standing.team_id WHERE groups = ?"
                let rows = try Row.fetchCursor(db, sql: sqlCommand,arguments: [group])
                while let row = try rows.next() {
                    let tempData:[String:String] = [
                        "id": row["id"],
                        "uuid": row["uuid"],
                        "name": row["name"],
                        "fifa_code": row["fifa_code"],
                        "score_mp": row["score_mp"],
                        "score_w": row["score_w"],
                        "score_l": row["score_l"],
                        "score_pts": row["score_pts"],
                        "score_gf": row["score_gf"],
                        "score_ga": row["score_ga"],
                        "score_gd": row["score_gd"],
                        "score_d": row["score_d"]
                    ]
                    dataFetchArray.append(tempData)
                }
                print(dataFetchArray)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func GetTeamDetailByTeamID(team_id:String) {
        do {
            try dbQueue.read { db in
                let sqlCommand = "SELECT team.id AS id, team.uuid AS uuid, name, fifa_code, iso2,score_mp, score_w, score_l, score_pts, score_gf, score_ga, score_gd, score_d FROM team INNER JOIN standing ON team.id = standing.team_id WHERE team.id = ?"
                if let row = try Row.fetchOne(db, sql: sqlCommand,arguments: [team_id]) {
                    dataFetchOne["id"] = row["id"]
                    dataFetchOne["uuid"] = row["uuid"]
                    dataFetchOne["name"] = row["name"]
                    dataFetchOne["fifa_code"] = row["fifa_code"]
                    dataFetchOne["score_mp"] = row["score_mp"]
                    dataFetchOne["score_w"] = row["score_w"]
                    dataFetchOne["score_l"] = row["score_l"]
                    dataFetchOne["score_pts"] = row["score_pts"]
                    dataFetchOne["score_gf"] = row["score_gf"]
                    dataFetchOne["score_ga"] = row["score_ga"]
                    dataFetchOne["score_gd"] = row["score_gd"]
                    dataFetchOne["score_d"] = row["score_d"]
                }
                print(dataFetchOne)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func GetAllMatchByTeamID(team_id:String) {
        do {
            try dbQueue.read { db in
                let sqlCommand = "SELECT matchdata.id AS id, t1.name AS away_team_name, away_score, away_score_player, t2.name AS home_team_name, home_score, home_score_player, matchday, local_date, t1.fifa_code AS away_flag, t2.fifa_code AS home_flag  FROM matchdata  INNER JOIN team t1 ON matchdata.away_team_id = t1.id  INNER JOIN team t2 ON matchdata.home_team_id = t2.id WHERE matchdata.away_team_id = ? OR matchdata.home_team_id = ? ORDER BY matchday ASC"
                let rows = try Row.fetchCursor(db, sql: sqlCommand,arguments: [team_id,team_id])
                while let row = try rows.next() {
                    let tempData:[String:String] = [
                        "id": row["id"],
                        "away_team_name": row["away_team_name"],
                        "away_score": row["away_score"],
                        "away_score_player": row["away_score_player"],
                        "home_team_name": row["home_team_name"],
                        "home_score": row["home_score"],
                        "home_score_player": row["home_score_player"],
                        "matchday": row["matchday"],
                        "away_flag": row["away_flag"],
                        "home_flag": row["home_flag"],
                        "local_date": row["local_date"]
                    ]
                    dataFetchArray.append(tempData)
                }
                print(dataFetchArray)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func InsertRegisterMember(name:String,username:String,password:String) -> Bool {
        do {
            try dbQueue.write { db in
                let sqlCommand = "INSERT INTO member (name, username, password) VALUES (?,?,?)"
                try db.execute(sql: sqlCommand, arguments: [name, username, password])
            }
            
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func CheckIsMemberExist(username:String) -> Bool {
        dataFetchArray.removeAll()
        do {
            try dbQueue.read { db in
                let sqlCommand = "SELECT id FROM member WHERE username = ?"
                let rows = try Row.fetchCursor(db, sql: sqlCommand,arguments: [username])
                while let row = try rows.next() {
                    let tempData:[String:String] = [
                        "id": row["id"]
                    ]
                    dataFetchArray.append(tempData)
                }
                
                print(dataFetchArray)
            }
            if dataFetchArray.count == 0 {
                return false
            }
        } catch {
            print(error.localizedDescription)
            return true
        }
        return true
    }
    
    func CheckLoginMember(username:String,password:String) -> Bool {
        dataFetchArray.removeAll()
        do {
            try dbQueue.read { db in
                let sqlCommand = "SELECT id,name FROM member WHERE username = ? AND password = ?"
                let rows = try Row.fetchCursor(db, sql: sqlCommand,arguments: [username,password])
                while let row = try rows.next() {
                    let tempData:[String:String] = [
                        "id": row["id"],
                        "name": row["name"]
                    ]
                    dataFetchArray.append(tempData)
                }
                
                print(dataFetchArray)
            }
            if dataFetchArray.count == 1 {
                return true
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
        return false
    }
    
    func CheckIsFavorite(teamid:String,userid:String) -> Bool {
        do {
            try dbQueue.read { db in
                let sqlCommand = "SELECT id FROM favorite_team WHERE team_id = ? AND member_id = ?"
                let rows = try Row.fetchCursor(db, sql: sqlCommand,arguments: [teamid,userid])
                while let row = try rows.next() {
                    let tempData:[String:String] = [
                        "id": row["id"]
                    ]
                    favdataFetchArray.append(tempData)
                }
                
                print(favdataFetchArray)
            }
            if favdataFetchArray.count == 0 {
                return false
            }else{
                return true
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func AddFavorite(teamid:String,userid:String) -> Bool {
        do {
            try dbQueue.write { db in
                let sqlCommand = "INSERT INTO favorite_team (team_id,member_id) VALUES (?,?)"
                try db.execute(sql: sqlCommand, arguments: [teamid, userid])
            }
            
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func UnFavorite(teamid:String,userid:String) -> Bool {
        do {
            try dbQueue.write { db in
                let sqlCommand = "DELETE FROM favorite_team WHERE team_id = ? AND member_id = ?"
                try db.execute(sql: sqlCommand, arguments: [teamid, userid])
            }
            
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
//    GetAllFavTeam
    func GetAllFavTeam(userid:String) {
        do {
            try dbQueue.read { db in
                let sqlCommand = "SELECT team.id AS id, team.uuid AS uuid, name, fifa_code, iso2,score_mp, score_w, score_l, score_pts, score_gf, score_ga, score_gd, score_d FROM favorite_team INNER JOIN team ON favorite_team.team_id = team.id INNER JOIN standing ON team.id = standing.team_id WHERE favorite_team.member_id = ?"
                let rows = try Row.fetchCursor(db, sql: sqlCommand,arguments: [userid])
                while let row = try rows.next() {
                    let tempData:[String:String] = [
                        "id": row["id"],
                        "uuid": row["uuid"],
                        "name": row["name"],
                        "fifa_code": row["fifa_code"],
                        "score_mp": row["score_mp"],
                        "score_w": row["score_w"],
                        "score_l": row["score_l"],
                        "score_pts": row["score_pts"],
                        "score_gf": row["score_gf"],
                        "score_ga": row["score_ga"],
                        "score_gd": row["score_gd"],
                        "score_d": row["score_d"]
                    ]
                    dataFetchArray.append(tempData)
                }
                print(dataFetchArray)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func TestShowAllFavorite() {
        favdataFetchArray.removeAll()
        do {
            try dbQueue.read { db in
                let sqlCommand = "SELECT id,member_id,team_id FROM favorite_team"
                let rows = try Row.fetchCursor(db, sql: sqlCommand)
                while let row = try rows.next() {
                    let tempData:[String:String] = [
                        "id": row["id"],
                        "member_id": row["member_id"],
                        "team_id": row["team_id"],
                    ]
                    favdataFetchArray.append(tempData)
                }
                
                print(favdataFetchArray)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
   
}

