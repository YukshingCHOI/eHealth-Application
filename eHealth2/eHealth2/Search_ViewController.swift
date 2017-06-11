//
//  ViewController.swift
//  eHealth2
//
//  Created by Yukshing CHOI on 10/6/2017.
//  Copyright © 2017 Yukshing CHOI. All rights reserved.
//

import UIKit
import Foundation

class Search_ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = Bundle.main.path(forResource: "eHealth_ProductList", ofType: "txt")
        let fm = FileManager.default
        if fm.fileExists(atPath: path!){
            do{
                let fullText = try! String(contentsOfFile: path!, encoding: String.Encoding.utf8)
                print(fullText)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

