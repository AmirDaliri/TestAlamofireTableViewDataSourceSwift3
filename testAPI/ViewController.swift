//
//  ViewController.swift
//  testAPI
//
//  Created by Amir Daliri on 1/31/17.
//  Copyright © 2017 Amir Daliri. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController , UITableViewDataSource {
    
    var videos = [Video]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Alamofire.request("http://www.aparat.com/etc/api/mostviewedvideos").validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                for (_,subJson) : (String , JSON) in json["mostviewedvideos"] {
                    let temp = Video(title: subJson["title"].string!, username: subJson["username"].string!)
                    self.videos.append(temp)
                }
                
                
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = videos[indexPath.row].title
        cell.detailTextLabel?.text = videos[indexPath.row].username
        
        
        
        return cell
    }
    
    
    
}

