//
//  MainTableViewController.swift
//  WordPursuit
//
//  Created by Eren Elçi on 8.10.2024.
//

import UIKit

class MainTableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func duygularButton(_ sender: Any) {
        performSegue(withIdentifier: "toPlayVc", sender: "Duygular")
        
    }
    @IBAction func nesneButton(_ sender: Any) {
        performSegue(withIdentifier: "toPlayVc", sender: "Nesneler")
    }
    
    @IBAction func renklerButton(_ sender: Any) {
        performSegue(withIdentifier: "toPlayVc", sender: "Renkler")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPlayVc" {
            if let gameVc = segue.destination as? GameViewController {
                if let selectedGame = sender as? String {
                    gameVc.selectedGame = selectedGame
                }
            }
        }
    }
    
    
     
    
}
