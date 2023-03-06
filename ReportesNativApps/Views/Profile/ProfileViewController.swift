//
//  ProfileViewController.swift
//  ReportesNativApps
//
//  Created by Valeria Henao on 4/03/23.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController{
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
    }
    
    @IBAction func closeSession(_ sender: Any) {
        let loginViewController = Controller.loginViewController()
        loginViewController.modalPresentationStyle = .fullScreen
        self.present(loginViewController, animated: true, completion: nil)
    }
}
