//
//  ReportsViewModelDelegate.swift
//  ReportesNativApps
//
//  Created by Valeria Henao on 6/03/23.
//

import Foundation
import CoreData

protocol ReportsViewModelDelegate: AnyObject {
    func viewModel(result: [NSManagedObject])
    func viewModel(createdReport: Bool)
}


extension ReportsViewModelDelegate {
    func viewModel(result: [NSManagedObject]){}
    func viewModel(createdReport: Bool){}
}
