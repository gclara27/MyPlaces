//
//  DetailController.swift
//  MyPlaces
//
//  Created by user145617 on 9/21/18.
//  Copyright © 2018 UOC. All rights reserved.
//

import UIKit

class DetailController: UIViewController {
    
    var place:Place? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.constraintHeight.constant = 400

        // Do any additional setup after loading the view.
        descField.text = place?.Description
        nameField.text = place?.Name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeDetail(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var constraintHeight: NSLayoutConstraint!

    @IBOutlet weak var descField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
