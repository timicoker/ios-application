//
//  AthleteViewController.swift
//  RASE
//
//  Created by Sam Beaulieu on 6/14/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit
import os.log

class PackageViewController: UITableViewController {
    
    // MARK: Properties
    
    // JSON Object with available packages -> Would pull from backend
    var payload =
        [
            "packages":
            [
                [
                    "name": "Basic Training Package",
                    "description": "$29.95\n \t• 3-Week program\n\t• Experienced coach monitoring your progress\n\t• Tailored performance drills on a weekly basis",
                    "image":"Basic Package"
                ],
                [
                    "name": "Premium Training Package",
                    "description":"$59.95\n \t• 6-week program\n\t• Experienced coach that monitors progress\n\t• Tailored performance drills on a weekly basis\n\t• Game film analysis and feedback provided by coaches\n\t• Constant contact with the assigned coach",
                    "image":"Premium Package"
                ]
            ]
        ]
    
    // Will be used in final application, above is just for testing
    var packages: [[String: Any]] = []
    var packageAmount = 0
    var packagesLoaded = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: payload, options: [])
            let json = try JSONSerialization.jsonObject(with: jsonData, options: [])  as? [String: Any]
            packages = json?["packages"] as! [[String: Any]]
            packageAmount = 0
            for packs in packages
            {
                if let _ = packs["name"] as? String {
                    packageAmount += 1
                }
            }
        } catch{
            print("ERROR")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
        print("Appeared!")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return packageAmount
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "PackageViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PackageViewCell else {
            fatalError("The dequeued cell is not an instance of PackageViewCell.")
        }
        if(packagesLoaded < packageAmount)
        {
            print(packagesLoaded)
            let currentPackage = packages[packagesLoaded] as [String: Any]
            print(currentPackage)
            cell.packageTitle.text = currentPackage["name"] as? String
            cell.packageDescription.text = currentPackage["description"] as? String
            cell.packageImage.image = UIImage(named: currentPackage["image"] as! String)
            cell.packageDescription.setContentOffset(CGPoint.zero, animated: false)
            
            packagesLoaded += 1
        }
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
  /*  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 */
    
    
    
    // Override to support editing the table view.
   /* override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }*/
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
}

