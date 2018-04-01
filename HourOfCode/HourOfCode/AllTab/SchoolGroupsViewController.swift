//
//  SchoolGroupsViewController.swift
//  HourOfCode
//
//  Created by Roksolana Kosiv on 4/1/18.
//  Copyright © 2018 Roksolana Kosiv. All rights reserved.
//

import UIKit

struct GroupSection {
    var title: String
    var groups:[GroupObject] = []
}

class SchoolGroupsViewController: UIViewController {
    
    var sectionTitles:[String] = []
    
    var school: SchoolObject?
    var dataSource: [GroupSection] = []
    
    var selectedGroup:GroupObject?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataManager.getSchoolGroups(id: school?.id ?? 0, callback: { (success, groupsArray, errorString) in
            if success {
                if let array = groupsArray {
                    self.dataSource.removeAll()
                    self.dataSource = self.formDataSource(array: array)
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? GroupDetailsViewController {
            vc.group = selectedGroup
            vc.school = school
            vc.isMyScheduleItem = false
        }
    }
    
    func formDataSource(array: [GroupObject]) -> [GroupSection] {
        var sections: [GroupSection] = []
        for group in array {
            guard let d2 = group.dateStart else { return [] }
            let filtered = array.filter {
                guard let d = $0.dateStart  else { return false }
                return Date.ifSameDate(date1: d, date2: d2)
            }
            let section = GroupSection(title: group.startDateString, groups: filtered)
            if !sections.contains(where: {$0.title == section.title}) {
                sections.append(section)
            }
        }
        return sections
    }
}

extension SchoolGroupsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath)
        let group = dataSource[indexPath.section].groups[indexPath.row]
        cell.textLabel?.text = "\(group.startTimeString) \(group.name)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource[section].title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedGroup = dataSource[indexPath.section].groups[indexPath.row]
        performSegue(withIdentifier: "GroupDetails", sender: self)
    }
    
}
