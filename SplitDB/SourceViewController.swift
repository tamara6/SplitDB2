//
//  SourceViewController.swift
//  SplitDB
//
//  Created by Tamara Snyder on 5/16/20.
//  Copyright © 2020 Tamara Snyder. All rights reserved.
//  this is a new version Dec. 2021...
//

import Cocoa
import GRDB

class SourceViewController:  NSViewController {
  
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var wordSearch: NSTextField!
    @IBOutlet weak var categorySearch: NSTextField!
    @IBOutlet weak var theButton: NSButton!
    @IBOutlet weak var idSearch: NSTextField!
    
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
    
    @IBAction func openTestWindowButton(_ sender: Any) {
     print("clicked the button to open the test window")
     
        
        let storyboardName = NSStoryboard.Name(stringLiteral: "Main")
            let storyboard = NSStoryboard(name: storyboardName, bundle: nil)
         
            let storyboardID = NSStoryboard.SceneIdentifier(stringLiteral: "allTestsDisplayStoryboardID")
         
            if let testsDisplayWindowController = storyboard.instantiateController(withIdentifier: storyboardID) as? NSWindowController {
         
                testsDisplayWindowController.showWindow(nil)
                testsWindowOpen = true
            } //end let...
        
    } //end openTestWindowButton
    
    
    @IBAction func buttonClick(_ sender: Any) {
        
        if dbQueue != nil {
            
            var s = ""
            print("ButtonClick: it isnt nil 3")
            let searchTerm = wordSearch.stringValue
            let category = categorySearch.stringValue
            let idsearch = idSearch.stringValue
            
            if !idsearch.isEmpty {
                //set the other two fields to blank if only searching for an ID
                categorySearch.stringValue = ""
                wordSearch.stringValue = ""
            }
            
            // send things off to do the searching....
            s = Question.qsearch(wordsearch: searchTerm, catsearch: category, idsearch: idsearch)
            
            //print("the return from Question is " + s)
            
            //display the results of the search
            resultsLabel.stringValue = "\(dbQuestions.count) records found"
                
            /*
            for row in dbQuestions {
            let question: String = row["question"]
                print(question)
            }
            */
                
            tableView.reloadData()
            
        } else {
            //the database is nil
            print("ButtonClick: it is nil 3")
        }
        
    } //end button click
    
    
    func tableViewSelectionDidChange(_ notification: Notification)
    {
       guard tableView.selectedRow != -1 else { return }
       guard let splitVC = parent as? NSSplitViewController else
    { return }
       if let detail = splitVC.children[1] as? DetailViewController
    {
        
        let theRow = tableView.selectedRow
        print("theRow is \(theRow)")
        detail.showQuestion(row: theRow)
    } }
    
    
    
}


extension SourceViewController: NSTableViewDataSource {
  
  func numberOfRows(in tableView: NSTableView) -> Int {
    // returns the number of rows in the db search results
    
    if dbQueue != nil {
        print("number of rows is : \(dbQuestions.count)")
        return dbQuestions.count
         
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
    
    
   let item = dbQuestions[row] //this gets the row from the database search result
    
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
