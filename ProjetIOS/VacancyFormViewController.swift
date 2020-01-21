//
//  VacancyFormViewController.swift
//  ProjetIOS
//
//  Created by etudiant on 21/01/2020.
//  Copyright © 2020 Kilian Pasini. All rights reserved.
//

import UIKit
import MessageUI

class VacancyFormViewController: UIViewController, MFMailComposeViewControllerDelegate {

    var holiday: Holiday?
    
    @IBOutlet weak var ui_nom: UITextField!
    @IBOutlet weak var ui_prenom: UITextField!
    @IBOutlet weak var ui_age: UITextField!
    @IBOutlet weak var ui_description: UITextView!
    @IBOutlet weak var ui_valider: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(holiday?.name)
        self.ui_description.layer.borderColor = UIColor.lightGray.cgColor
        self.ui_description.layer.borderWidth = 1.0;
        self.ui_description.layer.cornerRadius = 8;

    }
    
    func sendEmail() {
         
        let prenom = ui_prenom.text!
        let nom = ui_nom.text!
        let age = ui_age.text!
        let description : String = ui_description.text
        let nameVacance = holiday?.name
        let dateVacance = holiday?.date
        
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setToRecipients(["mathieu.menu02@gmail.com"])
        mail.setSubject("Bonjour \(prenom) \(nom)")
        mail.setMessageBody("<p>Nom : \(nom)</p><p>Prenom : \(prenom)</p><p>Age : \(age)</p><p>Description : \(description)</p><p>Nom du férié :\(nameVacance ?? "")</p><p>Date du férié : \(dateVacance)</p>", isHTML: true)

        present(mail, animated: true)
        
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

    @IBAction func validate(_ sender: Any) {
        
        if !MFMailComposeViewController.canSendMail() {
            
            let alert = UIAlertController(title: "Emails", message: "Envoi d'emails non supportés", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            
            }))
            self.present(alert, animated: true, completion: nil)
            
            
        }else{
            sendEmail()
        }
        
    }
}
