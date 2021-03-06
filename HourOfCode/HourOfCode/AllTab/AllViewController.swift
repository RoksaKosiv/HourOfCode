//
//  AllViewController.swift
//  HourOfCode
//
//  Created by Roksolana Kosiv on 3/31/18.
//  Copyright © 2018 Roksolana Kosiv. All rights reserved.
//

import UIKit

class AllViewController: CollapsibleTableSectionViewController {
    
    let viewModel = AllViewModel()
    
    var selectedSchool: SchoolObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.delegate = self
        viewModel.loadAllTabsData {
            self._tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SchoolGroupsViewController {
            vc.school = selectedSchool
            selectedSchool = nil
        }
    }
}

extension AllViewController: CollapsibleTableSectionDelegate {
    func numberOfSections(_ tableView: UITableView) -> Int {
        return viewModel.dataSource.count
    }
    
    func collapsibleTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func collapsibleTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell? ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = viewModel.titleForRowWithIndexPath(indexPath: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    
    func collapsibleTableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForSection(section: section)
    }
    
    func collapsibleTableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSchool = viewModel.selectetRowAtIndexPath(indexPath: indexPath)
        self.performSegue(withIdentifier: "GroupsSegue", sender: self)
    }
    
    func shouldCollapseByDefault(_ tableView: UITableView) -> Bool {
        return false
    }
}
