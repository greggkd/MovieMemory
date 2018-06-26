//
//  ThanksViewController.swift
//  MovieMemory
//
//  Created by Karen Gregg on 6/25/18.
//  Copyright © 2018 Karen Gregg. All rights reserved.
//

import UIKit

class ThanksViewController: UIViewController {

    @IBAction func thanksButton(_ sender: Any) {
        self.performSegue(withIdentifier: "backToMain", sender: self)
    }

    //MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "backToMain"{
            // Create a variable that you want to send
            //let newVar = self.model.puppyData.allPuppies
            
            // Create a new variable to store the instance of PlayerTableViewController
            _ = segue.destination as! ViewController
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
