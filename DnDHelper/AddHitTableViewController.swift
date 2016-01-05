//
//  AddHitTableViewController.swift
//  DnDHelper
//
//  Created by Logan Smith on 1/3/16.
//  Copyright © 2016 Logan Smith. All rights reserved.
//

import UIKit

class AddHitTableViewController: UITableViewController {

    var damage: Int?
    var participantIndex: Int!

    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var damageField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddHit" {
            damage = Int( damageField.text! )
        }
    }

    @IBAction func updateDamage( sender: UITextField ) {
        checkIfEligibleForDone()
    }

    func checkIfEligibleForDone() {
        var eligible = true
        if let text = damageField.text {
            if text == "" {
                eligible = false
            }
            if let _ = Int( damageField.text! ) {
            } else {
                eligible = false
            }
        } else {
            eligible = false
        }

        doneButton.enabled = eligible
    }
}
