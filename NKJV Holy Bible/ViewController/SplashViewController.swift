//
//  SplashViewController.swift
//  NKJV Holy Bible
//
//  Created by ĐINH HUY PHU on 09/11/2021.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var runCount = 0
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            runCount += 1
            if runCount == 1 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
                timer.invalidate()
            }
        }
    }


}

