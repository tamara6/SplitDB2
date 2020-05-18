//
//  SourceViewController.swift
//  SplitDB
//
//  Created by Tamara Snyder on 5/16/20.
//  Copyright © 2020 Tamara Snyder. All rights reserved.
//

import Cocoa
import GRDB

class SourceViewController:  NSViewController {
  
   @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var wordSearch: NSTextField!
    @IBOutlet weak var categorySearch: NSTextField!
    @IBOutlet weak var theButton: NSButton!
    
    @IBOutlet weak var resultsLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        let path = NSHomeDirectory()
        print("ViewDidLoad: make sure the database is at \(path)/railsLite.db")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func buttonClick(_ sender: Any) {
        
        if dbQueue != nil {
            print("ButtonClick: it isnt nil 3")
            let searchTerm = wordSearch.stringValue
            let category = categorySearch.stringValue
            var categoryConnector = " and"
            var sqlSearch = ""
            
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
            
            print("sqlSearch is " + sqlSearch)
            do {
                   let rows = try dbQueue.read { db in
                    try Row.fetchAll(db,
                    sql: sqlSearch
                    )
                }
                dbRows = rows
                
                resultsLabel.stringValue = "\(dbRows.count) records found"
                
                print("size of rows is : \(rows.count)")
                for row in rows {
                let question: String = row["question"]
                    print(question)
                }
                
                tableView.reloadData()
                 
            } catch {
                print("caught - no playerCount")
                
            }
        } else {
            print("ButtonClick: it is nil 3")
        }
        
        
        
    }
    
    
    
}


extension SourceViewController: NSTableViewDataSource {
  
  func numberOfRows(in tableView: NSTableView) -> Int {
    // returns the number of rows in the db search results
    
    if dbQueue != nil {
        print("number of rows is : \(dbRows.count)")
        return dbRows.count
         
    } else {
        print("rows in tableview: it is nil 5")
    }
    return 0 //returns this if dbQueue is nil
  }

}


extension SourceViewController: NSTableViewDelegate {

  fileprivate enum CellIdentifiers {
    static let IDCell = "IDcellID"
    static let QuestionCell = "QuestioncellID"
  }

  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {

    var cellValue = ""
    var cellIdentifier = NSUserInterfaceItemIdentifier("")
    
    
   let item = dbRows[row] //this gets the row from the database search result
    
   //depending on the column, get the info from the dbRow from above
    
    if tableColumn?.identifier.rawValue == "idColumn" {
        cellValue = String(item["id"] as Int)
        cellIdentifier = NSUserInterfaceItemIdentifier("IDCellID")
        
    } else if tableColumn?.identifier.rawValue == "questionColumn" {
        cellValue = item["question"]
        cellIdentifier = NSUserInterfaceItemIdentifier("QuestionCellID")
    }
    
    //send it out to the table
    
    //find the cell in the table
    if let cell = tableView.makeView(withIdentifier: cellIdentifier, owner: nil) as? NSTableCellView {
    
    cell.textField?.stringValue = cellValue
    return cell
    }
    //if the cell can't be found
    print("not setting cell")
    return nil
  }

}
