//
//  TestsDisplayViewController.swift
//  SplitDB
//
//  Created by Tamara Snyder on 12/26/21.
//  Copyright © 2021 Tamara Snyder. All rights reserved.
//

import Cocoa
import GRDB

class TestsDisplayViewController: NSViewController {
    
    //put in @IBOutlets here
    @IBOutlet weak var tableView: NSTableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        var s = ""
        s = Exam.alltests()
        print(s)
        
        let path = NSHomeDirectory()
        print("ViewDidLoad: make sure the database is at \(path)/railsLite.db")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    
    @IBAction func closeWindow(_ sender: Any) {
        view.window?.close()
        //close the window
    }
    
} //end the class before the extensions
    
    extension TestsDisplayViewController: NSTableViewDataSource {
      
      func numberOfRows(in tableView: NSTableView) -> Int {
        // returns the number of rows in the db search results
        
        if dbQueue != nil {
            print("number of rows is : \(dbExams.count)")
            return dbExams.count
             
        } else {
            print("rows in tableview: it is nil 5")
        }
        return 0 //returns this if dbQueue is nil
      }

    } //end extension
    
    
    
extension TestsDisplayViewController: NSTableViewDelegate {

  fileprivate enum CellIdentifiers {
    static let IDCell = "IDcellID"
    static let TestCell = "TestcellID"
    static let ActiveCell = "ActivecellID"
  }

  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {

    var cellValue = ""
    var cellIdentifier = NSUserInterfaceItemIdentifier("")
    
    
   let item = dbExams[row] //this gets the row from the database search result
    
   //depending on the column, get the info from the dbRow from above
    
    if tableColumn?.identifier.rawValue == "numberColumn" {
        cellValue = String(item["id"] as Int)
        cellIdentifier = NSUserInterfaceItemIdentifier("TestNumberCellID")
        
    } else if tableColumn?.identifier.rawValue == "testColumn" {
        cellValue = item["name"]
        cellIdentifier = NSUserInterfaceItemIdentifier("TestNameCellID")
    } else if tableColumn?.identifier.rawValue == "activeColumn" {
        cellValue = String(item["active"] as Int)
        cellIdentifier = NSUserInterfaceItemIdentifier("TestActiveCellID")
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
    
} //end extension

    
    

