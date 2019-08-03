//
//  NewDetailsViewController.swift
//  ByjuAssignment
//
//  Created by Jitendra Kumar Agarwal on 26/07/19.
//  Copyright © 2019 Jitendra Kumar Agarwal. All rights reserved.
//

import UIKit

class NewsDetailsViewController: UIViewController {
    var newsDetailsModel: NewsHeadLines!
    @IBOutlet weak var tableNewsDetails: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableNewsDetails.rowHeight = UITableView.automaticDimension
        tableNewsDetails.addSubview(backButton)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    lazy var backButton: UIButton = {
        var aButton: UIButton = UIButton(frame: CGRect(x: 13, y: 29, width: 35, height:35))
        aButton.layer.cornerRadius = 0.5 * aButton.bounds.size.width
        aButton.clipsToBounds = true
        aButton.backgroundColor = UIColor.darkGray
        aButton.alpha = 0.3
        aButton.addTarget(self, action:#selector(self.backAction), for: .touchUpInside)
        aButton.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        return aButton
    }()
    
}
// MARK:- User Define
extension NewsDetailsViewController {
    @objc func backAction(sender:UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
// MARK:- Tableview Delagte and Datascource.
extension NewsDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsDetailsHeaderCell") as! NewsDetailsHeaderCell
        cell.datasource =  newsDetailsModel as AnyObject
        return cell
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return   UITableView.automaticDimension
    }
    
    }
