//
//  OptionsViewController.swift
//  NKJV Holy Bible
//
//  Created by ĐINH HUY PHU on 10/11/2021.
//

import UIKit

class OptionsViewController: UIViewController {
    @IBOutlet var ViewColor: UIView!
    @IBOutlet weak var View1: UIView!
    
    @IBOutlet weak var Cancel: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewColor.backgroundColor = .clear
        Cancel.layer.cornerRadius = 20
    }
    
    @IBAction func BtnCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func BackMain(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
