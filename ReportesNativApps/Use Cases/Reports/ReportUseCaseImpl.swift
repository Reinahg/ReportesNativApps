//
//  ReportUseCaseImpl.swift
//  ReportesNativApps
//
//  Created by Valeria Henao on 6/03/23.
//

import Foundation
import CoreData
import UIKit

class ReportUseCaseImpl: ReportUseCase{
    let userInfoRepository: ReportsRepository
    
    init(userInfoRepository: ReportsRepository = ReportsRepositoryImpl()) {
        self.userInfoRepository = userInfoRepository
    }
    
    func getReports(completion: @escaping ([NSManagedObject]) -> Void) {
        self.userInfoRepository.getReports(completion: { result in
            completion(result)
        })
    }
    
    func createReport(title: String, description: String, imageToSave: UIImage, completion: @escaping (Bool) -> Void) {
        self.userInfoRepository.createReport(title: title, description: description, imageToSave: imageToSave, completion: { result in
            completion(result)
        })
    }
}
