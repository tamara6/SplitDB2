//
//  Question.swift
//  SplitDB
//
//  Created by Tamara Snyder on 5/24/20.
//  Copyright © 2020 Tamara Snyder. All rights reserved.
//

import GRDB

struct Question {
    
    static func searchString(wordsearch: String, catsearch: String, idsearch: String) -> String {
        // this should return the search string for searching for a set of questions
        let searchTerm = wordsearch
        let category = catsearch
        let idsearch = idsearch
        var sqlSearch = ""
        var categoryConnector = " and"
        
        //if it is an idsearch, do it right away and send back results
        if !idsearch.isEmpty {
        sqlSearch = "SELECT * FROM questions WHERE ID = \(idsearch)"
        return sqlSearch
        }
        
        if searchTerm.isEmpty {
                sqlSearch = "SELECT * FROM questions"
                categoryConnector = " where"
            } else {
                sqlSearch = "SELECT * FROM questions WHERE question like '%" + searchTerm + "%'"
            }
        
            if !category.isEmpty {
                let catArray = category.components(separatedBy: [","," "])
                var catArray2: [String] = []
                for cat in catArray {
                    if !cat.isEmpty {
                        let cat2 = "category like '" + cat + "%'"
                        catArray2.append(cat2)
                    }
                }
                let joined = catArray2.joined(separator: " OR ")
            
                sqlSearch = sqlSearch + categoryConnector + " (" + joined + ")"
            }
            return sqlSearch
        
        
        
        
        
    } //end searchString
    
    static func qsearch(wordsearch: String, catsearch: String, idsearch: String) -> String {
                
        let searchTerm = wordsearch
        let category = catsearch
        let idsearch = idsearch
        
        
        
        //if it is a searchTerm and/or a category, then do that and send back results.
                
                
        /*
                var categoryConnector = " and"
                var sqlSearch = ""
                
                if !idsearch.isEmpty {
                    sqlSearch = "SELECT * FROM questions WHERE ID = \(idsearch)"
                } else {
                
                
                    if searchTerm.isEmpty {
                        sqlSearch = "SELECT * FROM questions"
                        categoryConnector = " where"
                    } else {
                        sqlSearch = "SELECT * FROM questions WHERE question like '%" + searchTerm + "%'"
                    }
                
                    if !category.isEmpty {
                        let catArray = category.components(separatedBy: [","," "])
                        var catArray2: [String] = []
                        for cat in catArray {
                            if !cat.isEmpty {
                                let cat2 = "category like '" + cat + "%'"
                                catArray2.append(cat2)
                            }
                        }
                        let joined = catArray2.joined(separator: " OR ")
                    
                        sqlSearch = sqlSearch + categoryConnector + " (" + joined + ")"
                    }
                    
                }
             */
        
             
                // now actually do the search
                
                var sqlSearch = searchString(wordsearch: searchTerm, catsearch: category, idsearch: idsearch)

         
                print("Question sqlSearch is " + sqlSearch)
                do {
                       let rows = try dbQueue.read { db in
                        try Row.fetchAll(db,
                        sql: sqlSearch
                        )
                    }
                    dbQuestions = rows
                    
                    /*
                    resultsLabel.stringValue = "\(dbRows.count) records found"
                    
                    print("size of rows is : \(rows.count)")
                    for row in rows {
                    let question: String = row["question"]
                        print(question)
                    }
                    
                    tableView.reloadData()
                    */
                     
                } catch {
                    print("caught - problem with question search")
                    
                }
            
          
            
        return sqlSearch
        
    } //end qsearch
    
    
} //end struct
