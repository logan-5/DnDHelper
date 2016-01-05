//
//  NewPlayerTableViewController.swift
//  DnDHelper
//
//  Created by Logan Smith on 1/2/16.
//  Copyright © 2016 Logan Smith. All rights reserved.
//

import UIKit

class NewPlayerTableViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var raceTextField: UITextField!
    @IBOutlet weak var classTextField: UITextField!

    @IBOutlet var tapGesture: UITapGestureRecognizer!

    var player: Character?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addGestureRecognizer( tapGesture )
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            nameTextField.becomeFirstResponder()
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SavePlayerDetail" {
            player = Character(name: nameTextField.text, race: raceTextField.text, class_: classTextField.text, npc: false )
        }
    }

    @IBAction func endEditingPlayer( sender: UITapGestureRecognizer ) {
        self.view.endEditing( true )
    }
}
