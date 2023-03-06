//
//  ReportsViewModel.swift
//  ReportesNativApps
//
//  Created by Valeria Henao on 6/03/23.
//

import Foundation
import CoreData
import UIKit

class ReportsViewModel {
    
    let reportsUseCase: ReportUseCase
    weak var delegate: ReportsViewModelDelegate?
    
    init(delegate: ReportsViewModelDelegate? = nil, reportUseCase: ReportUseCase = ReportUseCaseImpl()) {
        self.reportsUseCase = reportUseCase
        self.delegate = delegate
    }
    
    func getReports(){
        reportsUseCase.getReports(completion: {[weak self] result in
            guard let self = self else { return }
            self.delegate?.viewModel(result: result)
        })
    }
    
    func createReport(title: String, description: String, imageToSave: UIImage){
        reportsUseCase.createReport(title: title, description: description, imageToSave: imageToSave, completion: {[weak self] wasCreated in
            guard let self = self else { return }
            self.delegate?.viewModel(createdReport: wasCreated)
        })
    }
}
