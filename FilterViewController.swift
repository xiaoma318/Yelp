//
//  FilterViewController.swift
//  MCYelp
//
//  Created by Cheng Ma on 9/21/14.
//  Copyright (c) 2014 Charlie. All rights reserved.
//

import UIKit
protocol FilterViewControllerDelegate{
    func myVCDidFinish(controller:FilterViewController,sort:Int, meter:Int, category:String)
}
class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var delegate:FilterViewControllerDelegate!
    var numInSection=[4,5,7]
    var filterString:String!="haha"
    var sortBy:Int!
    var category:String!
    var distance:Int!
    var nameInSection=["Sort by", "Distance", "Categories"]
    var table=[["Best Match","Distance","Rating","Most Reviewed"],
        ["Auto","0.3 miles","1 miles","5 miles","20 miles"],["Arts & Entertainment","Beauty & Spas","Education","Financial Services","Food","Health & Medical","Home Services","Hotels & Travel","Real Estate"]]
    var dictionary = ["Arts & Entertainment":"arts","Beauty & Spas":"beautysvc","Education":"education","Financial Services":"financialservices","Food":"food","Health & Medical":"health","Home Services":"homeservices","Hotels & Travel":"hotelstravel","Real Estate":"realestate"]
    @IBOutlet weak var tableView: UITableView!


     var isExpended:[Int:Bool] = [Int:Bool]()
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func search(sender: AnyObject) {
     filterString="&sort=2"
        sortBy = 2;
        distance = 1600;
        category="food"
        if (delegate != nil) {
           
            delegate!.myVCDidFinish(self, sort: sortBy, meter: distance, category: category)
        }
        
    }



    var isExpand: [Int: Bool] = [Int: Bool] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 40;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (isExpand[section] == nil || isExpand[section]==false) {
            return 1;
        } else {
            return numInSection[section];
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("TableCell") as TableViewCell
        switch (indexPath.section){
        case 0:
            cell.mLabel.text=table[0][indexPath.row]
            cell.deals.hidden = false
        case 1:
             cell.mLabel.text=table[1][indexPath.row]
        case 2:
             cell.mLabel.text=table[2][indexPath.row]
          
        case 3:
             cell.mLabel.text=table[3][indexPath.row]
           
            
        default:
             cell.mLabel.text="haha"
        }
       
        
       // cell.mLabel.text = "Row: \(indexPath.row), Section: \(indexPath.section)"
        
        return cell;
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        headerView.backgroundColor = UIColor.lightGrayColor()
        
        var Label = UILabel(frame: CGRect(x: 10, y: 20, width: 300, height: 20))
        Label.font = UIFont.systemFontOfSize(15)
        Label.text = nameInSection[section];
        headerView.addSubview(Label);
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        if (isExpand[indexPath.section] == nil || isExpand[indexPath.section] == false){
            isExpand[indexPath.section] = true
        }
        else {
            isExpand[indexPath.section] = false;
            
        }
        let rowNum = indexPath.row
        let sectionNum = indexPath.section
        var temp = table[sectionNum][rowNum]
        table[sectionNum][rowNum] = table[sectionNum][0]
        table[sectionNum][0] = temp
        
        tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    
    

}
