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

    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var teacherName: UILabel!
    @IBOutlet weak var phoneNumberLabel: UITextField!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!

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
        
        if let group = group {
            self.schoolNameLabel.text = group.name
            self.timeLabel.text = group.startDateString + " " + group.startTimeString
            self.detailsLabel.text = group.details
        }
        
        if let school = school {
            self.addressLabel.text = school.address
        }
        
        if let teacher = teacher {
            self.teacherName.text = teacher.username
            self.phoneNumberLabel.text = teacher.telephone
        }
        
    }

}
