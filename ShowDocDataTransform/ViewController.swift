//
//  ViewController.swift
//  ShowDocDataTransform
//
//  Created by lixiangzhou on 2018/9/9.
//  Copyright © 2018年 lixiangzhou. All rights reserved.
//

import Cocoa

struct ShowDocRowDataModel {
    var name: String?
    var type: String?
    var desc: String?
}

class ViewController: NSViewController {
    @IBOutlet weak var languageBox: NSComboBox!
    
    @IBOutlet var inputView: NSTextView!
    @IBOutlet var resultView: NSTextView!
    
    var data = [ShowDocRowDataModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        languageBox.removeAllItems()
        languageBox.addItems(withObjectValues: ["Objective-C", "Swift"])
        languageBox.selectItem(at: 0)
    }

    @IBAction func generateAction(_ sender: Any) {
        let components = inputView.string.components(separatedBy: "\n")
        let row = components.count / 3
        data.removeAll()
        
        for i in 0..<row {
            let start = i * 3
            let end = start + 3
            let rowData = components[start..<end]
            print(rowData)
            let model = ShowDocRowDataModel(name: rowData[start], type: rowData[start + 1], desc: rowData[start + 2])
            data.append(model)
        }
        
        var string = ""
        for model in data {
            let type = (model.type ?? "").lowercased()
            var s = "\n/// \(model.desc ?? "")\n"
            
            if languageBox.indexOfSelectedItem == 0 {   // oc
                switch type {
                case "float", "double":
                    s += "@property (nonatomic, assign) CGFloat \(model.name ?? "");"
                case "int":
                    s += "@property (nonatomic, assign) NSInteger \(model.name ?? "");"
                case "bool", "boolean":
                    s += "@property (nonatomic, assign) BOOL \(model.name ?? "");"
                case "string":
                    s += "@property (nonatomic, copy) NSString *\(model.name ?? "");"
                default:
                    s += "@property (nonatomic, <#type#>) <#type#> \(model.name ?? "");"
                }
                string += s
            } else {    // swift
                switch type {
                case "float", "double":
                    s += "var \(model.name ?? ""): Double = 0"
                case "int":
                    s += "var \(model.name ?? ""): Int = 0"
                case "bool", "boolean":
                    s += "var \(model.name ?? ""): Bool = false"
                case "string":
                    s += "var \(model.name ?? ""): String = \("")"
                default:
                    s += "var \(model.name ?? ""): <#type#> = "
                }
                string += s

            }
        }
        
        resultView.string = string
    }
}

