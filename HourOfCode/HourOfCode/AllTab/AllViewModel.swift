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
    var districtDataSource: [AllSection] = []
    var timeDataSource: [AllSection] = []
    
    var districtsArray: [DistrictObject] = [] {
        didSet {
            districtDataSource = []
            for dist in districtsArray {
                var schools: [AllCellItem] = []
                for item in dist.schoolArray {
                    schools.append(AllCellItem(title: item.name ?? ""))
                }
                districtDataSource.append(AllSection(title: dist.name!, sectionItems: schools))
            }
        }
    }
    
    
    var selectedSegmentType: DataSourceType = .list
    
    func changeDataSource() {
        switch selectedSegmentType {
        case .list:
            dataSource = districtDataSource
        case .time:
            dataSource = timeDataSource
        default:
            dataSource = districtDataSource
        }
    }
    
    func loadAllTabsData(completion: @escaping (() -> Void)) {
        DispatchQueue.global().async {
            self.loadDistrictsData(completion: completion)
        }
    }
    
    func loadDistrictsData(completion: @escaping (() -> Void)) {
        DataManager.getDiscticts { (success, districts, erroString) in
            if success {
                self.districtsArray = districts!
                self.changeDataSource()
                completion()
            }
        }
    }
    
    
    //MARK: Table View
    
    func numberOfRowsInSection(section: Int) -> Int {
        return  dataSource[section].sectionItems.count
    }
    
    func titleForSection(section: Int) -> String {
        return dataSource[section].title
    }
    
    func titleForRowWithIndexPath(indexPath: IndexPath) -> String {
        return dataSource[indexPath.section].sectionItems[indexPath.row].title
    }
    
    func selectetRowAtIndexPath(indexPath: IndexPath) -> SchoolObject? {
        let section = indexPath.section
        let row = indexPath.row
        if section < districtsArray.count {
            if row < districtsArray[section].schoolArray.count {
                return districtsArray[section].schoolArray[row] as SchoolObject
            }
        }
        return nil
    }
}
