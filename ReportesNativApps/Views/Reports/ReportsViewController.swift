//
//  ReportsViewController.swift
//  ReportesNativApps
//
//  Created by Valeria Henao on 4/03/23.
//
 
import Foundation
import UIKit
import CoreData

class ReportsViewController: UIViewController{
    
    @IBOutlet weak var collectionReports: UICollectionView!
    @IBOutlet weak var btnCreateReport: UIButton!
    
    var viewModel: ReportsViewModel?
    var reports = [NSManagedObject]()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        btnCreateReport.addTarget(self, action: #selector(createReport), for: .touchUpInside)
        registerViewModel()
        self.collectionReports.register(UINib.init(nibName: "ReportViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
    
    private func registerViewModel() {
        viewModel = ReportsViewModel(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.getReports()
    }
    
    @objc func createReport(){
        goToCreateReport()
    }
    
    func goToCreateReport(){
        let createReportViewController = Controller.createReportViewController()
        createReportViewController.modalPresentationStyle = .fullScreen
        self.present(createReportViewController, animated: true, completion: nil)
    }
    
    func loadImageFromDiskWith(fileName: String) -> UIImage? {
        
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
        }
        return nil
    }
    
}

// MARK: - Extension ReportsDelegate
extension ReportsViewController: ReportsViewModelDelegate {
    func viewModel(result: [NSManagedObject]){
        reports.removeAll()
        for data in result {
            reports.append(data)
        }
        collectionReports.reloadData()
    }
}


// MARK: - Extension Collections
extension ReportsViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        reports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! ReportViewCell
        
        if let title = self.reports[indexPath.row].value(forKey: "title") as? String, let description = self.reports[indexPath.row].value(forKey: "descriptionReport") as? String{
            cell.imgReport.image = UIImage(data: self.reports[indexPath.row].value(forKey: "imageReport") as! Data)
            cell.lblTitleReport.text = title
            cell.lblDescription.text = description
        }
        return cell
    }
}
