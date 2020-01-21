//
//  ViewController.swift
//  ProjetIOS
//
//  Created by Kilian Pasini on 21/01/2020.
//  Copyright © 2020 Kilian Pasini. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
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
        getHolidays(choiceCountry, choiceYear)
    }
    // Number of columns of data
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        // The number of rows of data
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
         choiceYear = pickerDataYear[row] as String

     } else if (pickerView == uiPickerCountry) {
         choiceCountry = pickerDataCountry[row] as String
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
    
    @IBOutlet weak var holidayTableView: UITableView!
    @IBOutlet weak var uiPickerCountry: UIPickerView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    @IBOutlet weak var uiPickerYear: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.uiPickerYear.delegate = self
        self.uiPickerYear.dataSource = self
        
        self.uiPickerCountry.delegate = self
        self.uiPickerCountry.dataSource = self
        
        self.holidayTableView.delegate = self
        self.holidayTableView.dataSource = self
        
        for index in 1980...2020 {
            pickerDataYear.append("\(index)")
        }
        getHolidays(choiceCountry, choiceYear)
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
       
        // DEPUIS STORYBOARD INSTANCE
        /*let mainStorybard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = mainStorybard.instantiateViewController(withIdentifier: "detailVC") as? DetailViewController {
            detailVC.person = listOfContacts[indexPath.row]
            self.navigationController?.pushViewController(detailVC, animated: true)
        }*/
        
        //AVEC LES SEGUE
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

