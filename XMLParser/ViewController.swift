//
//  ViewController.swift
//  XMLParser
//
//  Created by JSMAC on 2020/07/08.
//  Copyright © 2020 JSPRO. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, XMLParserDelegate {
    var dataList = [[String:String]]()
    var detailData = [String:String]()
    var elementTemp:String = ""
    var blank:Bool = false
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WetherCell
        let dictTemp = dataList[indexPath.row]
        cell.countryLabel.text = dictTemp["country"]
        let weatherStr = dictTemp["weather"]
        cell.weatherLabel.text = weatherStr
        cell.temperatureLabel.text = dictTemp["temperature"]
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "https://raw.githubusercontent.com/ChoiJinYoung/iphonewithswift2/master/weather.xml"
        guard let baseURL = URL(string: urlString) else {
            print("ULR error")
            return
        }
        
        guard let parser = XMLParser(contentsOf: baseURL) else {
            print("Can't read data")
            return
        }
        
        parser.delegate = self
        if !parser.parse() {
            print("Parse failure")
        }
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        elementTemp = elementName
        blank = true
        print("start : \(elementName)")
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if blank == true && elementTemp != "local" && elementTemp != "weatherinfo" {
            detailData[elementTemp] = string.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        print("string : \(string)")
        print("detailData : \(detailData)")

    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "local" {
            dataList += [detailData]
        }
        blank = false
    }


}

