//
//  AllViewModel.swift
//  HourOfCode
//
//  Created by Roksolana Kosiv on 3/31/18.
//  Copyright © 2018 Roksolana Kosiv. All rights reserved.
//

import UIKit

struct AllSection {
    var title: String = ""
    var sectionItems: [AllCellItem] = []
}

struct AllCellItem {
    var title:String = ""
}

enum DataSourceType: Int {
    case list = 0, time, search
}

class AllViewModel: NSObject {
    
    var dataSource: [AllSection] = []
    var selectedSegmentType: DataSourceType = .list
    
    override init() {
        super.init()
        dataSource = [
            AllSection(title: "District 1", sectionItems: [AllCellItem(title: "School 1"), AllCellItem(title: "School 2"), AllCellItem(title: "School 3")]),
            AllSection(title: "District 2", sectionItems: [AllCellItem(title: "School 1"), AllCellItem(title: "School 2"), AllCellItem(title: "School 3")]),
            AllSection(title: "District 3", sectionItems: [AllCellItem(title: "School 1"), AllCellItem(title: "School 2"), AllCellItem(title: "School 3")]),
            AllSection(title: "District 4", sectionItems: [AllCellItem(title: "School 1"), AllCellItem(title: "School 2"), AllCellItem(title: "School 3")])
        ]
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return  dataSource[section].sectionItems.count
    }
    
    func titleForSection(section: Int) -> String {
        return dataSource[section].title
    }
    
    func titleForRowWithIndexPath(indexPath: IndexPath) -> String {
        return dataSource[indexPath.section].sectionItems[indexPath.row].title
    }
}
