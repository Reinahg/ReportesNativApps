//
//  CreateReportViewController.swift
//  ReportesNativApps
//
//  Created by Valeria Henao on 4/03/23.
//

import UIKit
import CoreData

class CreateReportViewController: UIViewController {
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfDescription: UITextView!
    @IBOutlet weak var btnCreateReport: UIButton!
    @IBOutlet weak var btnCreate: UIButton!
    @IBOutlet weak var imageReport: UIImageView!
    @IBOutlet weak var btnTakeImage: UIButton!
    
    var imageToSave : UIImage?
    var imagePath = ""
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var viewModel: ReportsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnCreateReport.addTarget(self, action: #selector(validateFields), for: .touchUpInside)
        btnTakeImage.addTarget(self, action: #selector(takeImage), for: .touchUpInside)
        self.hideKeyboardWhenTappedAround()
        registerViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imagePath = "image_\(NSDate().timeIntervalSince1970)"
    }
    
    private func registerViewModel() {
        viewModel = ReportsViewModel(delegate: self)
    }
    
    @IBAction func actionDismiss(_ sender: Any) {
        dismiss(animated: true)
    }
    @objc func validateFields(){
        if let title = tfTitle.text, let description = tfDescription.text, let imageReport = imageToSave {
            viewModel?.createReport(title: title, description: description, imageToSave: imageReport)
        }
    }
    
}

extension CreateReportViewController : ReportsViewModelDelegate {
    func viewModel(createdReport: Bool) {
        if createdReport {
            dismiss(animated: true)
            
        }
    }
}

extension CreateReportViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
    @objc func takeImage() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        self.imageToSave = image
        imageReport.image = image
        imageReport.isHidden = false
        btnTakeImage.isHidden = true
        saveImage(imageName: imagePath, image: image)
    }
    
    func saveImage(imageName: String, image: UIImage) {
        
        
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileName = imageName
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return }
            if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }
        }
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("error saving file with error", error)
        }
        
    }
}
