//
//  EncounterTableViewController.swift
//  DnDHelper
//
//  Created by Logan Smith on 1/2/16.
//  Copyright © 2016 Logan Smith. All rights reserved.
//

import UIKit

class EncounterTableViewController: UITableViewController {

    var encounter = Encounter()

    @IBOutlet var popOverButton: UIButton!

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
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return encounter.participants.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EncounterParticipant", forIndexPath: indexPath)

        let participant = encounter.participants[indexPath.row]
        var nameToDisplay = String(indexPath.row+1) + ". "
        if let name = participant.character.name {
            nameToDisplay += name
        } else {
            nameToDisplay += participant.character.descriptionString
        }
        cell.textLabel?.text = nameToDisplay
        if participant.character.npc {
            cell.detailTextLabel?.text = String(participant.character.hp!)
            cell.detailTextLabel?.textColor = getTextColorForPercentage( Double(participant.character.hp!), den: Double(participant.character.maxHp!) )
        } else {
            cell.detailTextLabel?.text = ""
            cell.accessoryType = .None
        }

        return cell
    }

    func getTextColorForPercentage( num: Double, den: Double ) -> UIColor {
        guard den > 0.0 else { return UIColor.blackColor() }
        let ratio = num / den
        if ratio == 0 {
            return UIColor( red: 0.6, green: 0, blue: 0.6, alpha: 1 )
        } else if ratio < 0.33 {
            return UIColor( red: 0.6, green: 0, blue: 0, alpha: 1 )
        } else if ratio < 0.66 {
            return UIColor( red: 0.6, green: 0.6, blue: 0, alpha: 1 )
        } else {
            return UIColor( red: 0, green: 0.6, blue: 0, alpha: 1 )
        }
    }

    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        openCustomPopoverForIndexPath( indexPath )
    }

    var cellRowTapped = 0
    func openCustomPopoverForIndexPath( indexPath: NSIndexPath ) {
        let cell = self.tableView( tableView, cellForRowAtIndexPath: indexPath )

        let displayFrom = CGRectMake(cell.frame.origin.x + cell.frame.size.width, cell.center.y + self.tableView.frame.origin.y - self.tableView.contentOffset.y, 1, 1)

        self.popOverButton.frame = displayFrom
        self.performSegueWithIdentifier( "CustomPopoverSegue", sender: cell )
        cellRowTapped = indexPath.row
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func newEncounter( sender: UIBarButtonItem ) {
        encounter = Encounter()
        tableView.reloadData()
    }

    @IBAction func cancelAddNew( segue: UIStoryboardSegue ) {

    }

    @IBAction func cancelHit( segue: UIStoryboardSegue ) {
        
    }

    @IBAction func addNew( segue: UIStoryboardSegue ) {
        if let playerDetailsViewController = segue.sourceViewController as? AddParticipantTableViewController {

            //add the new player to the players array
            for player in playerDetailsViewController.participants {
                encounter.participants.append(player)

                tableView.reloadData()
            }
        }
    }

    @IBAction func addHit( segue: UIStoryboardSegue ) {
        if let addHitViewController = segue.sourceViewController as? AddHitTableViewController {
            encounter.participants[cellRowTapped].character.hit( addHitViewController.damage! )
        }
        tableView.reloadData()
    }

}
