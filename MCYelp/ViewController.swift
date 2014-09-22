//
//  ViewController.swift
//  MCYelp
//
//  Created by Cheng Ma on 9/21/14.
//  Copyright (c) 2014 Charlie. All rights reserved.
//

import UIKit


class ViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate,FilterViewControllerDelegate {
    var client: YelpClient!
    
    let yelpConsumerKey = "vxKwwcR_NMQ7WaEiQBK_CA"
    let yelpConsumerSecret = "33QCvh5bIF5jIHR5klQr7RtBDhQ"
    let yelpToken = "uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV"
    let yelpTokenSecret = "mqtKIxMIR4iBtBPZCmCLEb-Dz3Y"
    
    @IBOutlet weak var searchBar: UISearchBar!

    var bussinesses: [NSDictionary] = []
    


    @IBOutlet weak var resultTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

       self.navigationItem.titleView = searchBar
        resultTable.delegate = self
        resultTable.dataSource = self
       resultTable.rowHeight=UITableViewAutomaticDimension
        resultTable.estimatedRowHeight = 85.0
        searchBar.delegate = self
        
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
    {
        return bussinesses.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell = tableView.dequeueReusableCellWithIdentifier("ResturantCell") as ResturantCell
        var bussiness = bussinesses[indexPath.row]
        
        let str1 = "\(indexPath.row+1). "
        let str2 = bussiness["name"] as String
        cell.name.text = "\(str1)\(str2)"
        
        let profileUrl = bussiness["image_url"] as String
        cell.profile.setImageWithURL(NSURL(string:profileUrl))
        
        let ratingUrl = bussiness["rating_img_url"] as String
        cell.review.setImageWithURL(NSURL(string:ratingUrl))
        
        let reviewCount = bussiness["review_count"] as Int
        let str3 = " reviews"
        cell.reviewCount.text = "\(reviewCount)\(str3)"
      
        let location = bussiness["location"] as NSDictionary
        let address = location["address"]as [String]
        if(address.count>0){
        cell.address.text = address[0]
        }
        
        let categories = bussiness["categories"] as [NSArray]
        var temp = ""
        for item in categories{
            temp+=item[0] as String
        }
        cell.kind.text=temp
        
        return cell
    }
    
     func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        client.searchWithTerm(searchBar.text, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            self.bussinesses = response["businesses"] as [NSDictionary]
            self.resultTable.reloadData()
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
    }
    
    func myVCDidFinish(controller: FilterViewController, sort: Int, meter:Int, category:String) {
      
        controller.dismissViewControllerAnimated(true, completion: nil)
       
        client.searchWithFilter(searchBar.text,sort:sort  ,distance:meter,success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            self.bussinesses = response["businesses"] as [NSDictionary]
            self.resultTable.reloadData()
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
    }
  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "mSegue"{
            let vc = segue.destinationViewController as FilterViewController
            vc.delegate = self
  
        }
    }
    
  

}

