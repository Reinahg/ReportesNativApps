//
//  Controller.swift
//  ReportesNativApps
//
//  Created by Valeria Henao on 4/03/23.
//

import Foundation
import UIKit

class Controller {
    static func homeViewController() -> HomeViewController {
        let storyBoard: UIStoryboard = UIStoryboard(name: Constans.storyBoardName.home, bundle: nil)
        let homeViewController = storyBoard.instantiateViewController(withIdentifier: Constans.viewControllerName.homeView) as! HomeViewController
        return homeViewController
    }
    
    static func createReportViewController() -> CreateReportViewController {
        let storyBoard: UIStoryboard = UIStoryboard(name: Constans.storyBoardName.createReport, bundle: nil)
        let createReportViewController = storyBoard.instantiateViewController(withIdentifier: Constans.viewControllerName.createReport) as! CreateReportViewController
        return createReportViewController
    }
    
    static func loginViewController() -> LoginViewController {
        let storyBoard: UIStoryboard = UIStoryboard(name: Constans.storyBoardName.loginView, bundle: nil)
        let loginViewController = storyBoard.instantiateViewController(withIdentifier: Constans.viewControllerName.loginView) as! LoginViewController
        return loginViewController
    }
}
