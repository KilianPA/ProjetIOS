//
//  ViewController.swift
//  ProjetIOS
//
//  Created by Kilian Pasini on 21/01/2020.
//  Copyright © 2020 Kilian Pasini. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var text_country_input: UITextField!
    @IBOutlet weak var text_year_input: UITextField!
    @IBOutlet weak var holidayTableView: UITableView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    var uiPickerYear : UIPickerView!
    var uiPickerCountry : UIPickerView!

    var pickerDataYear: [String] = [String]()
    var pickerDataCountry = ["FR", "US", "CH"]
    var choiceYear = "1980"
    var choiceCountry = "FR"
    var listHolidays: [Holiday] = []
    var selectedHoliday: Holiday?
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
    }
     
    @IBAction func searchHolidays(_ sender: Any) {
        getHolidays(text_country_input.text ?? "FR", text_year_input.text ?? "1980")
    }
    
    @objc func doneClickYear() {
        text_year_input.resignFirstResponder()

    }
    @objc func cancelClickYear() {
        text_year_input.resignFirstResponder()
    }
    
    
    @objc func doneClickCountry() {
        text_country_input.resignFirstResponder()

    }
    @objc func cancelClickCountry() {
        text_country_input.resignFirstResponder()
    }
    
    func pickUpCountry () {
        self.uiPickerCountry = UIPickerView()
        self.uiPickerCountry.delegate = self
        self.uiPickerCountry.dataSource = self
        self.uiPickerCountry.backgroundColor = UIColor.white
        
        text_country_input.inputView = self.uiPickerCountry

        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.sizeToFit()

        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Valider", style: .plain, target: self, action: #selector(doneClickCountry))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Annuler", style: .plain, target: self, action: #selector(cancelClickCountry))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        text_country_input.inputAccessoryView = toolBar
    }
    
    func pickUpYear(){

                    self.uiPickerYear = UIPickerView()
                    self.uiPickerYear.delegate = self
                    self.uiPickerYear.dataSource = self
                    self.uiPickerYear.backgroundColor = UIColor.white

        text_year_input.inputView = self.uiPickerYear

        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.sizeToFit()

        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Valider", style: .plain, target: self, action: #selector(doneClickYear))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Annuler", style: .plain, target: self, action: #selector(cancelClickYear))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        text_year_input.inputAccessoryView = toolBar

    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
                if (pickerView == uiPickerYear) {
                    return pickerDataYear.count

                } else if (pickerView == uiPickerCountry) {
                    return pickerDataCountry.count
                }
            return 0
        }

    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == uiPickerYear) {
            text_year_input.text = pickerDataYear[row] as String

     } else if (pickerView == uiPickerCountry) {
            text_country_input.text = pickerDataCountry[row] as String
     }
    }
        
        // The data to return fopr the row and component (column) that's being passed in
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if (pickerView == uiPickerYear) {
                return pickerDataYear[row]

            } else if (pickerView == uiPickerCountry) {
                return pickerDataCountry[row]
            }
            return ""
        }
    
        override func viewDidLoad() {
        super.viewDidLoad()
                
        self.holidayTableView.delegate = self
        self.holidayTableView.dataSource = self
        
        for index in 1980...2020 {
            pickerDataYear.append("\(index)")
        }
            
        pickUpCountry()
        pickUpYear()
            getHolidays(text_country_input.text ?? "FR", text_year_input.text ?? "1980")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        holidayTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHolidayItem" {
            let detailVacancy = segue.destination as? VacancyFormViewController
            detailVacancy?.holiday = selectedHoliday
        }
    }
    
    func getHolidays (_ country:String,_ year:String)
    {
        self.loading.startAnimating()
        let apiKey = "209a28f24db3dc00c092d0852732611712440638"
    //    var url = "https://calendarific.com/api/v2/holidays?api_key=\(apiKey)&country=\(country)&year=\(year)"
        var url = "https://calendarific.com/api/v2/holidays?api_key=\(apiKey)&country=\(country)&year=\(year)"
        AF.request(url, method: .get).responseDecodable { [weak self] (response: DataResponse<Vacancy, AFError>) in switch response.result {
        case .success(let data):
            self?.loading.stopAnimating()
            self?.listHolidays = (data.response?.holidays)!
            self!.holidayTableView.reloadData()
            break
        case .failure(let error):
            self?.loading.stopAnimating()
            print(error)
            }
        }
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        selectedHoliday = listHolidays[indexPath.row]
        self.performSegue(withIdentifier: "showHolidayItem", sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listHolidays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if let cellDynamique = tableView.dequeueReusableCell(withIdentifier: "holidayCellID", for: indexPath) as? HolidayCellViewTableViewCell {
            
            let holiday = listHolidays[indexPath.row]
            cellDynamique.fill(withHoliday: holiday)
            return cellDynamique
        }else {
            return UITableViewCell()
        }
    }
}

