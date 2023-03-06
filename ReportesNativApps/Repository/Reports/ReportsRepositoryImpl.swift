//
//  ReportsRepositoryImpl.swift
//  ReportesNativApps
//
//  Created by Valeria Henao on 6/03/23.
//

import Foundation
import CoreData
import UIKit

class ReportsRepositoryImpl: ReportsRepository{
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func getReports(completion: @escaping ([NSManagedObject]) -> Void) {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Report")
        //request.predicate = NSPredicate(format: "age = %@", "21")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            completion(result as! [NSManagedObject])
            
        } catch {
            print("Failed")
        }
    }
    
    func createReport(title: String, description: String, imageToSave: UIImage, completion: @escaping (Bool) -> Void){
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Report", in: context)
        let newReport = NSManagedObject(entity: entity!, insertInto: context)
        
        newReport.setValue(NSDate().timeIntervalSince1970, forKey: "id")
        newReport.setValue(description, forKey: "descriptionReport")
        newReport.setValue(title, forKey: "title")
        newReport.setValue(imageToSave.pngData(), forKey: "imageReport")
        do { 
            try context.save()
            completion(true)
        } catch {
            completion(false)
        }
    }
}
