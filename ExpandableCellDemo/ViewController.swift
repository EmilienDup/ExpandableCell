//
//  ViewController.swift
//  ExpandableCellDemo
//
//  Created by YiSeungyoun on 2017. 8. 6..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import UIKit
import ExpandableCell

class ViewController: UIViewController {
    @IBOutlet var tableView: ExpandableTableView!
    var parentCells: [[String]] = [
        [ExpandableCell2.ID,
         NormalCell.ID,
         ExpandableCell2.ID,
         ExpandableSelectableCell2.ID,
         NormalCell.ID
        ],
        [ExpandableCell2.ID,
         NormalCell.ID,
         ExpandableCell2.ID,
         ExpandableInitiallyExpanded.ID
        ]
    ]

    var cell: UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: ExpandedCell.ID)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.expandableDelegate = self
        tableView.animation = .automatic
        
        tableView.register(UINib(nibName: "NormalCell", bundle: nil), forCellReuseIdentifier: NormalCell.ID)
        tableView.register(UINib(nibName: "ExpandedCell", bundle: nil), forCellReuseIdentifier: ExpandedCell.ID)
//        tableView.register(UINib(nibName: "ExpandableCell", bundle: nil), forCellReuseIdentifier: ExpandableCell2.ID)
        tableView.register(ExpandableCell2.self, forCellReuseIdentifier: ExpandableCell2.ID)
        tableView.register(UINib(nibName: "ExpandableSelectableCell", bundle: nil), forCellReuseIdentifier: ExpandableSelectableCell2.ID)
           tableView.register(UINib(nibName: "InitiallyExpandedExpandableCell", bundle: nil), forCellReuseIdentifier: ExpandableInitiallyExpanded.ID)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        tableView.openAll()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openAllButtonClicked() {
        tableView.openAll()
    }
    
    @IBAction func expandMultiButtonClicked(_ sender: Any) {
        tableView.expansionStyle = .multi
    }
    
    @IBAction func expandSingleButtonClicked(_ sender: Any) {
        tableView.expansionStyle = .single
        tableView.closeAll()
    }
    
    @IBAction func closeAllButtonClicked() {
        tableView.closeAll()
    }
    
    @IBAction func SelectionDisplayOn(_ sender: UIButton) {
        tableView.autoRemoveSelection = !tableView.autoRemoveSelection
        let isOn = tableView.autoRemoveSelection ? "Off" : "On"
        sender.setTitle("Selection Stays \(isOn)", for: .normal)
    }
    
    //scroll view methods are being forwarded correctly
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollViewDidScroll")
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scrollViewDidScroll, decelerate:\(decelerate)")
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print("scrollViewDidEndScrollingAnimation")
    }
}

extension ViewController: ExpandableDelegate {
    
    @objc(expandableTableView:expandedCellsForRowAt:)
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCellsForRowAt indexPath: IndexPath) -> [UITableViewCell]? {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell1 = tableView.dequeueReusableCell(withIdentifier: ExpandedCell.ID) as! ExpandedCell
                cell1.titleLabel.text = "First Expanded Cell"
                let cell2 = tableView.dequeueReusableCell(withIdentifier: ExpandedCell.ID) as! ExpandedCell
                cell2.titleLabel.text = "Second Expanded Cell"
                let cell3 = tableView.dequeueReusableCell(withIdentifier: ExpandedCell.ID) as! ExpandedCell
                cell3.titleLabel.text = "Third Expanded Cell"
                return [cell1, cell2, cell3]
                
            case 2:
                return [cell, cell]
            case 3:
                return [cell, cell, cell]
            case 5:
                return [cell, cell, cell]
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                let cell1 = tableView.dequeueReusableCell(withIdentifier: ExpandedCell.ID) as! ExpandedCell
                cell1.titleLabel.text = "First Expanded Cell - Section 2"
                return [cell1]
                
            case 2:
                return [cell, cell]
            case 3:
                return [cell, cell]
                
            default:
                break
            }
        default:
            break
        }
        return nil
    }
    
    @objc(expandableTableView:heightsForExpandedRowAt:)
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightsForExpandedRowAt indexPath: IndexPath) -> [CGFloat]? {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return [44, 44, 44]
                
            case 2:
                return [33, 33, 33]
                
            case 3:
                return [22]
            case 5:
                return [33, 33, 33]
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                return [44]
                
            case 2:
                return [33, 33]
                
            case 3:
                return [22]
                
            default:
                break
            }
        default:
            break
        }
        return nil
        
    }
    
    @objc(numberOfSectionsIn:)
    func numberOfSections(in tableView: ExpandableTableView) -> Int {
        return parentCells.count
    }
    
    @objc(expandableTableView:numberOfRowsInSection:)
    func expandableTableView(_ expandableTableView: ExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        return parentCells[section].count
    }
    
    @objc(expandableTableView:didSelectRowAt:)
    func expandableTableView(_ expandableTableView: ExpandableTableView, didSelectRowAt indexPath: IndexPath) {
//        print("didSelectRow:\(indexPath)")
    }
    
    @objc(expandableTableView:didSelectExpandedRowAt:)
    func expandableTableView(_ expandableTableView: ExpandableTableView, didSelectExpandedRowAt indexPath: IndexPath) {
//        print("didSelectExpandedRowAt:\(indexPath)")
    }
    
    @objc(expandableTableView:expandedCell:didSelectExpandedRowAt:)
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCell: UITableViewCell, didSelectExpandedRowAt indexPath: IndexPath) {
        if let cell = expandedCell as? ExpandedCell {
            print("\(cell.titleLabel.text ?? "")")
        }
    }
    
    @objc(expandableTableView:titleForHeaderInSection:)
    func expandableTableView(_ expandableTableView: ExpandableTableView, titleForHeaderInSection section: Int) -> String? {
        return "Section:\(section)"
    }
    
    @objc(expandableTableView:heightForHeaderInSection:)
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    @objc(expandableTableView:cellForRowAt:)
    func expandableTableView(_ expandableTableView: ExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = expandableTableView.dequeueReusableCell(withIdentifier: parentCells[indexPath.section][indexPath.row]) else { return UITableViewCell() }
        return cell
    }
    
    @objc(expandableTableView:heightForRowAt:)
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0, 2, 3:
                return 66
                
            case 1, 4:
                return 55
                
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0, 2, 3:
                return 66
                
            case 1, 4:
                return 55
                
            default:
                break
            }
        default:
            break
        }
        
        return 44
    }
    
    @objc(expandableTableView:didCloseRowAt:) func expandableTableView(_ expandableTableView: UITableView, didCloseRowAt indexPath: IndexPath) {
        let cell = expandableTableView.cellForRow(at: indexPath)
        cell?.contentView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        cell?.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
    }
    @objc(expandableTableView:shouldHighlightRowAt:)
    func expandableTableView(_ expandableTableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    @objc(expandableTableView:didUnhighlightRowAt:)
    func expandableTableView(_ expandableTableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
//        let cell = expandableTableView.cellForRow(at: indexPath)
//        cell?.contentView.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
//        cell?.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    }
    
    
    func expandableTableView(_ expandableTableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, titleForFooterInSection section: Int) -> String? {
        nil
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, viewForHeaderInSection section: Int) -> UIView? {
        nil
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, willDisplayFooterView view: UIView, forSection section: Int) {
    
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, didEndDisplaying cell: UITableViewCell, forRow indexPath: IndexPath) {
    
    }
//    func expandableTableView(_ expandableTableView: ExpandableTableView, titleForHeaderInSection section: Int) -> String? {
//        return "Section \(section)"
//    }
//    
//    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 33
//    }
}
