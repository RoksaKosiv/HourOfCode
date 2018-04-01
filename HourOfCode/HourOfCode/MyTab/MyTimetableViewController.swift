//
//  SettingsViewController.swift
//  HourOfCode
//
//  Created by Viktor Rudyk on 4/1/18.
//  Copyright © 2018 Roksolana Kosiv. All rights reserved.
//

import UIKit

class MyTimetableViewController: UIViewController {
    
    var myGroups:[GroupObject] = [] {
        didSet {
            myGroups = myGroups.sorted{
                guard let d1 = $0.dateStart, let d2 = $1.dateStart else { return false }
                return d1 < d2
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataManager.getMyGroups { (success, groupsArray, errorMessage) in
            if let groups = groupsArray, success {
                self.myGroups = groups
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func logOutAction(_ sender: Any) {
        APIClient.sharedInstance.logout()
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController = storyboard.instantiateViewController(withIdentifier: "LogInViewController")
            UIApplication.shared.delegate?.window??.rootViewController?.dismiss(animated: false, completion: nil)
            UIApplication.shared.keyWindow?.rootViewController = loginViewController
        }
    }
}


extension MyTimetableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return myGroups.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupCell", for: indexPath) as! MyGroupTableViewCell
        let group = myGroups[indexPath.section]
        cell.timeLabel.text = group.startDateString + " " + group.startTimeString + " - " + group.endTimeString
        cell.addressLabel.text = group.school?.address
        cell.schoolNameLabel.text = group.school?.name
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let group = myGroups[indexPath.section]
        let mainStoryboard: UIStoryboard? = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard?.instantiateViewController(withIdentifier: "GroupDetailsViewController") as! GroupDetailsViewController
        vc.group = group
        vc.isMyScheduleItem  = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
