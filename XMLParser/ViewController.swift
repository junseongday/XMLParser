//
//  ViewController.swift
//  XMLParser
//
//  Created by JSMAC on 2020/07/08.
//  Copyright © 2020 JSPRO. All rights reserved.
//

import UIKit

struct Weather:Decodable {
    let country:String
    let weather:String
    let temperature:String
}

class ViewController: UIViewController, UITableViewDataSource {
    var datalist = [Weather]()
    @IBOutlet weak var mainTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datalist.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let jsonURLString = "https://raw.githubusercontent.com/ChoiJinYoung/iphonewithswift2/master/swift4weather.json"
        guard let jsonURL = URL(string: jsonURLString) else {
            return
        }
        URLSession.shared.dataTask(with: jsonURL, completionHandler: {(data, response, error) -> Void in
            guard let data = data else {return}
            do {
                self.datalist = try JSONDecoder().decode([Weather].self, from: data)
//                print(self.datalist)
//                self.mainTableView.reloadData()
                DispatchQueue.main.async(execute: {
                    self.mainTableView.reloadData()
                })
            } catch let jsonErr {
                print("Parsing erro \(jsonErr)")
            }
            }).resume()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WetherCell
        let structTemp = datalist[indexPath.row]
        cell.countryLabel.text = structTemp.country
        let weatherStr = structTemp.weather
        cell.weatherLabel.text = weatherStr
        cell.temperatureLabel.text = structTemp.temperature
        if weatherStr == "맑음" {
            cell.imgView.image = UIImage(named: "sunny.png")
        } else if weatherStr == "비" {
            cell.imgView.image = UIImage(named: "rainy.png")
        } else if weatherStr == "흐림" {
            cell.imgView.image = UIImage(named: "cloudy.png")
        } else if weatherStr == "눈" {
            cell.imgView.image = UIImage(named: "snow.png")
        } else {
            cell.imgView.image = UIImage(named: "blizzard.png")
        }
        return cell
    }

}

