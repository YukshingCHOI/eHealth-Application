//
//  Exchange_ViewController.swift
//  eHealth2
//
//  Created by Yukshing CHOI on 10/6/2017.
//  Copyright © 2017 Yukshing CHOI. All rights reserved.
//

import Foundation
import UIKit

class Exchange_ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var Exchange_TableView: UITableView!
    
    var eachFood: [[String]]?
    var tableRow: Int?
    var foodConstant = [[Int]]()
    var foodName = [String]()
    var result = [[Double]]()
    var Exchange_input = [Double]()
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        print("Exchange tableView, tableRow = \(tableRow!)")
        return tableRow!
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "topic_cell", for: indexPath) as! Exchange_TableViewCell
            print("topic")
            cell.topic_label.text = "Nutrient Exchange Table"
            return cell
        }else if (indexPath.row == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "title_cell", for: indexPath) as! Exchange_TableViewCell
            print("title")
            return cell
        }else if (indexPath.row == tableRow! - 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "result_cell", for: indexPath) as! Exchange_TableViewCell
            ///////////Put code here//////////
            print("result")
            for i in 1 ..< (cell.total_label.count){
                for j in 2 ..< indexPath.row{
                    result[indexPath.row - 2][i - 1] += result[j - 2][i - 1]
                }
                (cell.total_label[i]).text = String(describing: result[indexPath.row - 2][i - 1])
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "input_cell", for: indexPath) as! Exchange_TableViewCell
            Exchange_input[indexPath.row - 2] = Double(cell.input_textfield.text!)!
            ///////////Put code here//////////
            print("input")
            (cell.input_textfield.delegate) = self
            cell.input_textfield.keyboardType = .decimalPad
            (cell.input_label[0]).text = foodName[indexPath.row - 2]
            for i in 1 ..< (cell.input_label).count{
                result[indexPath.row - 2][i - 1] = Double(foodConstant[indexPath.row - 2][i - 1]) * Exchange_input[indexPath.row - 2]
                (cell.input_label[i]).text = String(describing: (result[indexPath.row - 2][i - 1]))
            }
            return cell
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch string{
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            return true
        case ".":
            let array = textField.text
            var decimalCount:Int = 0
            for i in (array?.characters)! {
                if(i == "."){
                    decimalCount = 1
                }
                if(decimalCount > 0){
                    return false
                }
            }
            return true
        default:
            let array = string
            if(array.isEmpty){
                return true
            }
            return false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        result = Array(repeating: Array(repeatElement(0, count: foodConstant.count)), count: tableRow! - 2)
        self.Exchange_TableView.reloadData()
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        let path = Bundle.main.path(forResource: "eHealth_ExchangeTable", ofType: "txt")
        let fm = FileManager.default
        if fm.fileExists(atPath: path!){
            print("File Exist\n")
            do{
                let fileContent = try! String(contentsOfFile: path!, encoding: String.Encoding.utf8)
                let fileArray: [String] = fileContent.components(separatedBy: "\r") as [String]
                print("foodArray")
                print(fileArray)
                print("")
                tableRow = (fileArray.count + 2)
                // 2 is for: Topic and total
                print((fileArray[0].components(separatedBy: "\t").count) - 1)
                print(fileArray.count - 1)
                foodConstant = Array(repeating: Array(repeating: 0, count: (fileArray[0].components(separatedBy: "\t").count) - 1), count: fileArray.count - 1)
                for i in 1 ..< fileArray.count{
                    let foodInfo = fileArray[i].components(separatedBy: "\t") as [String]
                    print(foodInfo)
                    for j in 0 ..< (foodInfo.count){
                        print("i = \(i) j = \(j)")
                        if(j > 0){
                            let a = Int(foodInfo[j])!
                            foodConstant[i - 1][j - 1] = a
                        }else{
                            foodName.append(foodInfo[j])
                        }
                    }
                }
                print(foodName)
                print("")
                print(foodConstant)
                print("")
            }
        }else{
            print("File does not exist")
        }
        Exchange_input = Array(repeating: 0, count: tableRow! - 3)
        result = Array(repeating: Array(repeatElement(0, count: foodConstant.count)), count: tableRow! - 2)
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
