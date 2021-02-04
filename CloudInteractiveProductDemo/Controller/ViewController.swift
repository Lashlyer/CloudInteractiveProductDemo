//
//  ViewController.swift
//  CloudInteractiveProductDemo
//
//  Created by Alvin on 2021/2/1.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nextPageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func nextPageButton(_ sender: Any) {
        
        guard let seconVc = self.storyboard?.instantiateViewController(identifier: "SecondViewController") as? SecondViewController else { return }
        
        self.navigationController?.pushViewController(seconVc, animated: true)
    }
  
}

