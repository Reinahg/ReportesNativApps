//
//  ReportUseCase.swift
//  ReportesNativApps
//
//  Created by Valeria Henao on 6/03/23.
//

import Foundation
import CoreData
import UIKit

protocol ReportUseCase {
    func getReports(completion: @escaping ([NSManagedObject]) -> Void)
    func createReport(title: String, description: String, imageToSave: UIImage, completion: @escaping (Bool) -> Void)
}
