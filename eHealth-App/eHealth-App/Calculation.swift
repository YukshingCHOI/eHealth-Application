//
//  ViewController.swift
//  eHealth-App
//
//  Created by Yukshing CHOI on 8/6/2017.
//  Copyright © 2017 Yukshing CHOI. All rights reserved.
//

import UIKit

class Calculation_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    let item_list: [String] = ["Starch", "Meat", "Vegetable", "Fruit", "Milk", "Fat"]
    let nutrient_list: [String] = ["Carbohydrate","Protein","Fat", "Energy"]
    var input_values = [String]()
    var constant = [[Int]]()
    var sum = [Double]()
    
    @IBOutlet weak var Calculation_TableView: UITableView!
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        print("Calculation: tableView")
        return item_list.count + 2
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        print("Calculation: tableView setting cell")
        if(indexPath.row == 0){
            //Title
            let cell = tableView.dequeueReusableCell(withIdentifier: "title_cell", for: indexPath) as! Calculation_TableViewCell
            return cell
        }else if(indexPath.row == item_list.count + 1){
            //Total
            let cell = tableView.dequeueReusableCell(withIdentifier: "total_cell", for: indexPath) as! Calculation_TableViewCell
            for i in 1 ..< cell.total_label.count{
                (cell.total_label!)[i].text = String(sum[i-1])
            }
            return cell
        }else{
            //Input
            let cell = tableView.dequeueReusableCell(withIdentifier: "input_cell", for: indexPath) as! Calculation_TableViewCell
            cell.input_text_field!.delegate = self
            cell.input_text_field!.keyboardType = .decimalPad
            (cell.input_label!)[0].text = item_list[indexPath.row - 1]
            for i in 1 ..< cell.input_label.count{
                if !(((cell.input_text_field.text)?.isEmpty)!){
                    ////////
                    if let input: Double = Double((cell.input_text_field!).text!){
                        print("indexPath.row = \(indexPath.row) i = \(i) Double = \(constant[indexPath.row-1][i-1])")
                        let result = input * Double((constant[indexPath.row-1][i-1]))
                        sum[i-1] += result
                        (cell.input_label!)[i].text = String(result)
                        ///////
                    }else{
                        (cell.input_text_field!).text = "0"
                        (cell.input_label!)[i].text = "0"
                    }
                }else{
                    (cell.input_text_field!).text = "0"
                    (cell.input_label!)[i].text = "0"
                }
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
        self.view.endEditing(true)
        sum = [Double](repeatElement(0, count: nutrient_list.count))
        self.Calculation_TableView.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        sum = [Double](repeatElement(0, count: nutrient_list.count))
        self.Calculation_TableView.reloadData()
        return false
    }

    override func viewDidLoad() {
        print("Calculation: cellDidload")
        // Do any additional setup after loading the view, typically from a nib.
        constant = Array(repeating: Array(repeatElement(0, count: nutrient_list.count)), count: item_list.count)
        sum = Array(repeating: 0, count: nutrient_list.count)
        print(constant)
        if let path = Bundle.main.path(forResource: "ehealth-app-e8ff3-export", ofType: "txt"){
            let url = URL(fileURLWithPath: path)
            do{
                let data = try! Data(contentsOf: url)
                let json = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as AnyObject
                if let Nutrient = json["Nutrient"] as? NSDictionary{
                    for i in 0..<item_list.count{
                        if let food = Nutrient[item_list[i]] as? NSDictionary{
                            for j in 0..<nutrient_list.count{
                                if let compoenet = food[nutrient_list[j]] as? Int{
                                    constant[i][j] = compoenet
                                    
                                }else{
                                    print("compenet not found")
                                }
                            }
                        }
                    }
                }
            }
        }
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

