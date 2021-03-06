//
//  RecordsViewController.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/13.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit
import RealmSwift

enum PeriodType {
    case all,day,week,month,quarter,year,custom
}

struct PeriodData {
    var startDate: Date?
    var endDate: Date?
    /*static func getPeriodDataByPeriodType(type:PeriodType) -> PeriodData
    {
        var periodData:PeriodData
        switch type {
        case .all:
            periodData = PeriodData(nil, nil)
        case .day:
            Date(
        default:
            <#code#>
        }
        return periodData
    }*/
}

/*struct FilterModel {
    var period: PeriodData
    var activities: List<Activity>
    var tag:String
}*/

class RecordsViewController: BasicItemsTableViewController, EditRecordViewProtocol {
    
    var records: Results<ActivityRecord>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView!.register(RecordListTableViewCell.self, forCellReuseIdentifier: "RecordCell")
        
        records = DataManager.shareManager.getActivityRecords(from: nil, to: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath) as! RecordListTableViewCell
        let record = records![indexPath.row]
        cell.record = record
        return cell
    }
    
    override func tappedAddButton() {
        let vc = EditRecordViewController(with: nil, delegate: self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func longPressRow(at indexPath: IndexPath) {
        let record = records![indexPath.row]
        let vc = EditRecordViewController(with: record, delegate: self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let record = records![indexPath.row]
            DataManager.shareManager.deleteActivityRecord(record: record)
            self.tableView?.reloadData()
        }
    }
    
    func didEditRecord(editRecordModel:EditRecordModel) {
        switch editRecordModel.editType {
        case EditRecordType.modify:
            DataManager.shareManager.updateActivityRecord(record: editRecordModel.record!,
                                               activity: editRecordModel.activity,
                                               startTime: editRecordModel.startDate,
                                               endTime: editRecordModel.endDate,
                                               node: editRecordModel.node!)
        case EditRecordType.new:
            DataManager.shareManager.addActivityRecord(activity: editRecordModel.activity,
                                            startTime: editRecordModel.startDate,
                                            endTime: editRecordModel.endDate,
                                            node: editRecordModel.node!)
        }
        self.tableView?.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath)-> CGFloat {
        return 60
    }
}
