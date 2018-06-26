//
//  SplashViewController.swift
//  MovieMemory
//
//  Created by Karen Gregg on 6/24/18.
//  Copyright © 2018 Karen Gregg. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var lastTimeLbl: UILabel!
    var timeEnd = ""
    override func viewDidLoad() {
    
        super.viewDidLoad()

        timeLbl.text = timeEnd
        //UserDefaults.standard.set(timeLbl.text, forKey: "lastTime")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let x = UserDefaults.standard.object(forKey: "lastTime") as? String{
            lastTimeLbl.text = x
        }else
        {
            UserDefaults.standard.setValue(timeLbl.text, forKey: "lastTime")
        }
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
