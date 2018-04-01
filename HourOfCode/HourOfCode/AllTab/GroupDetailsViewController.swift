//
//  GroupDetailsViewController.swift
//  HourOfCode
//
//  Created by Roksolana Kosiv on 4/1/18.
//  Copyright © 2018 Roksolana Kosiv. All rights reserved.
//

import UIKit

class GroupDetailsViewController: UIViewController {
    
    var group: GroupObject?
    var teacher: TeacherObject?
    var school: SchoolObject?
    var isMyScheduleItem = false

    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var teacherName: UILabel!
    @IBOutlet weak var phoneNumberLabel: UITextField!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var buttonAction: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUIWithData()
        if let groupID = group?.id {
            DataManager.getTeacherForGroup(id: groupID, callback: { (success, teacherObj, errorString) in
                self.teacher = teacherObj
                self.updateUIWithData()
            })
        }
    }
    
    func updateUIWithData() {
        
        self.schoolNameLabel.text = ""
        self.timeLabel.text = ""
        self.detailsLabel.text = ""
        self.addressLabel.text = ""
        self.teacherName.text = ""
        self.phoneNumberLabel.text = ""
        
        if isMyScheduleItem {
            self.buttonAction.backgroundColor = UIColor(hex: 0xFD4600, alpha: 1.0)
            self.buttonAction.setTitle("Скасувати урок", for: .normal)
        }else {
            self.buttonAction.backgroundColor = UIColor(hex: 0x00ADBB, alpha: 1.0)
            self.buttonAction.setTitle("Взяти урок", for: .normal)
        }
        
        if let group = group {
            self.schoolNameLabel.text = group.name
            self.timeLabel.text = group.startDateString + " " + group.startTimeString
            self.detailsLabel.text = group.details
            
        }
        
        self.addressLabel.text = school?.address
        
        if let teacher = teacher {
            self.teacherName.text = teacher.username
            self.phoneNumberLabel.text = teacher.telephone
        }
        
    }

    @IBAction func manageSubscribtion(_ sender: Any) {
        if let id = group?.id {
            DataManager.subscribeToGroups(groupId: id, subscribe: !isMyScheduleItem, callback: { (success, error) in
                self.navigationController?.popViewController(animated: true)
                if self.isMyScheduleItem == false {
                    let item = self.tabBarController?.tabBar.items![1]
                    item?.badgeValue = "1"
                }
            })
        }
    }
    
    
}
