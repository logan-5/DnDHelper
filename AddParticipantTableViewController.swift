//
//  AddParticipantTableViewController.swift
//  DnDHelper
//
//  Created by Logan Smith on 1/3/16.
//  Copyright © 2016 Logan Smith. All rights reserved.
//

import UIKit

class AddParticipantTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet weak var npcOrPlayerControl: UISegmentedControl!
    @IBOutlet weak var npcNameField: UITextField!
    @IBOutlet weak var npcNameFieldCell: UITableViewCell!
    let npcNameFieldSection = 1
    @IBOutlet weak var hpCell: UITableViewCell!
    @IBOutlet weak var hpField: UITextField!
    let hpFieldSection = 2

    @IBOutlet weak var playerNamePickerCell: UITableViewCell!
    @IBOutlet weak var playerNamePicker: UIPickerView!
    let playerNamePickerSection = 3

    @IBOutlet weak var initiativeField: UITextField!

    @IBOutlet weak var quantityCell: UITableViewCell!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var quantityStepper: UIStepper!
    let quantitySection = 5

    var players = CharacterData.players

    @IBOutlet weak var doneButton: UIBarButtonItem!

    var participants: [Encounter.Participant] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer( tapGesture )

        playerNamePicker.dataSource = self
        playerNamePicker.delegate = self

        doneButton.enabled = false

        updateControls()
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
        return 6
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cell = self.tableView( tableView, cellForRowAtIndexPath: indexPath )

        if cell.hidden {
            return 0.0
        }

        return super.tableView( tableView, heightForRowAtIndexPath: indexPath )
    }

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let type = npcOrPlayerControl.titleForSegmentAtIndex(npcOrPlayerControl.selectedSegmentIndex)!
        if type == "NPC" {
            if section == playerNamePickerSection {
                return CGFloat.min
            }
        } else if type == "Player" {
            if section == npcNameFieldSection || section == hpFieldSection || section == quantitySection {
                return CGFloat.min
            }
        }
        return super.tableView( tableView, heightForHeaderInSection: section )
    }

    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let type = npcOrPlayerControl.titleForSegmentAtIndex(npcOrPlayerControl.selectedSegmentIndex)!
        if type == "NPC" {
            if section == playerNamePickerSection {
                return CGFloat.min
            }
        } else if type == "Player" {
            if section == npcNameFieldSection || section == hpFieldSection || section == quantitySection {
                return CGFloat.min
            }
        }
        return super.tableView( tableView, heightForFooterInSection: section )
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let type = npcOrPlayerControl.titleForSegmentAtIndex(npcOrPlayerControl.selectedSegmentIndex)!
        if type == "NPC" {
            if section == playerNamePickerSection {
                return ""
            }
        } else if type == "Player" {
            if section == npcNameFieldSection || section == hpFieldSection || section == quantitySection {
                return ""
            }
        }
        return super.tableView( tableView, titleForHeaderInSection: section )
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            npcNameField.becomeFirstResponder()
        } else if indexPath == 2 {
            hpField.becomeFirstResponder()
        } else if indexPath == 4 {
            initiativeField.becomeFirstResponder()
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddParticipant" {
            var name = ""
            var npc = false
            var hp = 0
            var quantity = 1
            let mode = npcOrPlayerControl.titleForSegmentAtIndex(npcOrPlayerControl.selectedSegmentIndex)!
            switch mode {
            case "NPC":
                npc = true
                name = npcNameField.text!
                hp = Int(hpField.text!)!
                quantity = Int(quantityStepper.value)
            case "Player":
                name = self.players[playerNamePicker.selectedRowInComponent(0)].name!
            default:
                break
            }

            for i in 1...quantity {
                let name_ = quantity > 1 ? name + " \(i)" : name
                let character = Character(name: name_, race: nil, class_: nil, npc: npc, hp: hp )

                participants.append( Encounter.Participant(character: character, initiative: Int(initiativeField.text!)! ) )
            }
        }
    }


    @IBAction func endEditingParticipant( sender: UITapGestureRecognizer ) {
        self.view.endEditing( true )
    }

    @IBAction func npcOrPlayerControlChanged( sender: UISegmentedControl ) {
        updateControls()
        checkIfEligibleForDone()
    }

    func updateControls() {
        switch npcOrPlayerControl.titleForSegmentAtIndex(npcOrPlayerControl.selectedSegmentIndex)! {
        case "NPC":
            playerNamePickerCell.hidden = true
            npcNameFieldCell.hidden = false
            hpCell.hidden = false
            quantityCell.hidden = false
        case "Player":
            npcNameFieldCell.hidden = true
            hpCell.hidden = true
            quantityCell.hidden = true
            playerNamePickerCell.hidden = false
        default:
            break
        }
        tableView.reloadData()
    }

    @IBAction func checkifDone( sender: UITextField ) {
        checkIfEligibleForDone()
    }

    func checkIfEligibleForDone() {
        var eligible = true
        if npcOrPlayerControl.titleForSegmentAtIndex(npcOrPlayerControl.selectedSegmentIndex)! == "NPC" {
            if npcNameField.text == "" {
                eligible = false
            }
            if let _ = Int(hpField.text!) {
            } else {
                eligible = false
            }
        }
        var initiativeEligible = true
        if let _ = Int(initiativeField.text!) {
        } else {
            initiativeEligible = false
        }
        initiativeEligible = initiativeEligible && initiativeField.text != ""
        eligible = eligible && initiativeEligible

        doneButton.enabled = eligible
    }

    @IBAction func quantityChanged( sender: UIStepper ) {
        quantityLabel.text = String(Int(quantityStepper.value))
    }


    // MARK: - Player Picker
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return players.count
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return players[row].name
    }
}
