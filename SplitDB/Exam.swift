//
//  Exam.swift
//  SplitDB
//
//  Created by Tamara Snyder on 12/24/21.
//  Copyright © 2021 Tamara Snyder. All rights reserved.
//
//  I copied this from Question and then modified it
//

import GRDB

struct Exam {
    
    
// first, return an array with all of the tests
    static func alltests() -> String {
                
                // now actually do the search
                
                print("Searching for all tests ")
                do {
                       let rows = try dbQueue.read { db in
                        try Row.fetchAll(db,
                        sql: "SELECT * FROM exams"
                        )
                    }
                    dbExams = rows
                    
                     
                } catch {
                    print("caught - problem with all test search")
                    
                }
            
          
        return "all"
        
    } //end alltests
    
    
/*
    
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
                    
                     
                } catch {
                    print("caught - problem with question search")
                    
                }
            
          
        return sqlSearch
        
    } //end qsearch
*/
    
} //end struct
