//
//  VacancyFormViewController.swift
//  ProjetIOS
//
//  Created by etudiant on 21/01/2020.
//  Copyright © 2020 Kilian Pasini. All rights reserved.
//

import UIKit
import MessageUI

class VacancyFormViewController: UIViewController, MFMailComposeViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate,UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var pickerDataAge: [String] = [String]()
    var holiday: Holiday?
    var pickedImage:UIImage?
    var choiceAge = "1"
    
    @IBOutlet weak var ui_nom: UITextField!
    @IBOutlet weak var ui_prenom: UITextField!
    @IBOutlet weak var ui_description: UITextView!
    @IBOutlet weak var ui_valider: UIButton!
    
    @IBOutlet weak var ui_image: UIImageView!
    @IBOutlet weak var ui_button: UIButton!
    @IBOutlet weak var ui_pickerAge: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.ui_description.layer.borderColor = UIColor.lightGray.cgColor
        self.ui_description.layer.borderWidth = 1.0;
        self.ui_description.layer.cornerRadius = 8;
        
        self.ui_nom.delegate = self
        self.ui_prenom.delegate = self
        self.ui_description.delegate = self
        
        self.ui_pickerAge.delegate = self
        self.ui_pickerAge.dataSource = self
        
        self.title = self.holiday?.name
        
        for index in 1...110 {
            pickerDataAge.append("\(index)")
        }
      
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerDataAge[row]

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataAge.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
         choiceAge = pickerDataAge[row] as String

    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func sendEmail() {
         
        let prenom = ui_prenom.text!
        let nom = ui_nom.text!
        let age = choiceAge
        let description : String = ui_description.text
        let nameVacance = holiday?.name
        let dateVacance = holiday?.date
        
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        
        let imageData = self.pickedImage!.jpegData(compressionQuality: 1)!
        mail.addAttachmentData(imageData, mimeType:"image/jpeg", fileName:"pic.jpeg")
        mail.setToRecipients(["valentindenis80@gmail.com"])
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

            print(choiceAge)
        }else{
            sendEmail()
        }
        
    }
    
    @IBAction func imagePicker(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        self.present(imagePickerController, animated: true, completion: nil)
    
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage

        ui_image.image = image
        
        self.pickedImage = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}
