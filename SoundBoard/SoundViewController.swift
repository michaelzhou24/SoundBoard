//
//  SoundViewController.swift
//  SoundBoard
//
//  Created by Michael Zhou on 2018-07-03.
//  Copyright © 2018 Michael Zhou. All rights reserved.
//

import UIKit

class SoundViewController: UIViewController {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func recordTapped(_ sender: Any) {
        print("Tapped record!")
    }
    
    @IBAction func playTapped(_ sender: Any) {
        print("Tapped play!")
    }

    @IBAction func addTapped(_ sender: Any) {
        print("Tapped add!")
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
