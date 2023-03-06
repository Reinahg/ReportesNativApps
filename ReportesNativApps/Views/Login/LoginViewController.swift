//
//  LoginViewController.swift
//  ReportesNativApps
//
//  Created by Valeria Henao on 4/03/23.
//

import Foundation
import UIKit
import FirebaseAuth

class LoginViewController: UIViewController{
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var viewPhone: UIView!
    @IBOutlet weak var viewVerify: UIView!
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var btnVerify: UIButton!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfCode: UITextField!
    
    var currentVerificationId = ""
    
    override func viewDidLoad(){
        super.viewDidLoad()
        btnContinue.addTarget(self, action: #selector(validatePhone), for: .touchUpInside)
        btnBack.addTarget(self, action: #selector(showPhoneViewObjc), for: .touchUpInside)
        btnVerify.addTarget(self, action: #selector(verifyCode), for: .touchUpInside)
        self.hideKeyboardWhenTappedAround()
    }
    
    @objc func verifyCode(){
        if let code = tfCode.text {
            verifyCodeCredential(code: code)
        }
    }
    
    private func verifyCodeCredential(code: String){
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: currentVerificationId, verificationCode: code)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                let _ = error as NSError
                return
            }
            self.goToHome()
        }
    }
    
    func goToHome(){
        let homeViewController = Controller.homeViewController()
        homeViewController.modalPresentationStyle = .fullScreen
        self.present(homeViewController, animated: true, completion: nil)
    }
    
    @objc func validatePhone(){
        if let phone = tfPhone.text {
            let phoneWithPrefix = Constans.dataFirebase.codeCountryColombia + phone
            sendsms(phone: phoneWithPrefix)
        }
    }
    
    @objc func showPhoneViewObjc(){
        showPhoneView()
    }
    
    private func sendsms(phone: String){
        PhoneAuthProvider.provider()
          .verifyPhoneNumber(phone, uiDelegate: nil) { verificationID, error in
              self.showVerify()
              if let error = error {
                print(error)
                return
              }
              self.currentVerificationId = verificationID!
          }
    }
    
    private func showVerify(){
        UIView.transition(with: view, duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: {
                         self.viewPhone.isHidden = true
                      })
        UIView.transition(with: view, duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: {
                         self.viewVerify.isHidden = false
                      })
        
    }
    
    private func showPhoneView(){
        UIView.transition(with: view, duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: {
                         self.viewVerify.isHidden = true
                      })
        UIView.transition(with: view, duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: {
                         self.viewPhone.isHidden = false
                      })
    }
    
}
