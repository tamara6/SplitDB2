//
//  DetailViewController.swift
//  SplitDB
//
//  Created by Tamara Snyder on 5/16/20.
//  Copyright © 2020 Tamara Snyder. All rights reserved.
//

import Cocoa

class DetailViewController: NSViewController {
    @IBOutlet weak var questionView: NSTextField!
    @IBOutlet weak var ansAView: NSTextField!
    @IBOutlet weak var ansBView: NSTextField!
    @IBOutlet weak var ansCView: NSTextField!
    @IBOutlet weak var ansDView: NSTextField!
    @IBOutlet weak var ansEView: NSTextField!
    @IBOutlet weak var popUpAnswer: NSMenu!
    @IBOutlet weak var popUpAns: NSPopUpButton!
    @IBOutlet weak var categoryView: NSTextField!
    @IBOutlet weak var randomizeCheck: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func showQuestion(row: Int) {
        
        var text: String = ""
        let item = dbRows[row]
        text = item["question"]
        questionView.stringValue = text
        ansAView.stringValue = item["a"]
        ansBView.stringValue = item["b"]
        ansCView.stringValue = item["c"]
        ansDView.stringValue = item["d"]
        ansEView.stringValue = item["e"]
        categoryView.stringValue = item["category"]
        
        var answer: String = ""
        answer = item["correct"]
        
        popUpAns.selectItem(withTitle: answer.uppercased())
        
        var doRandom: Bool = false
        
        
        
    }
    
}
