//
//  ViewController.swift
//  WordPursuit
//
//  Created by Eren Elçi on 8.10.2024.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func playButton(_ sender: Any) {
        performSegue(withIdentifier: "toMainVC", sender: nil)
    }
    
}

