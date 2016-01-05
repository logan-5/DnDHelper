//
//  Data.swift
//  DnDHelper
//
//  Created by Logan Smith on 1/2/16.
//  Copyright © 2016 Logan Smith. All rights reserved.
//

import UIKit

class Data: NSObject {
    class var sharedData: Data {
        get { return sharedInstance.sharedData }
    }
    private struct sharedInstance { static let sharedData = Data() }

    let defaults = NSUserDefaults.standardUserDefaults()

    override init() {
        let path = NSBundle.mainBundle().pathForResource( "Data", ofType: "plist" )
        let data = NSDictionary( contentsOfFile: path! )

        defaults.registerDefaults( data! as! [String : AnyObject] )
        super.init()
    }

    private var changedPlayers = true
    private var _savedPlayers: [Character]?
    var savedPlayers: [Character] {
        get {
            if changedPlayers {
                let defs = defaults.valueForKey("Players") as! NSArray
                var list = [Character]()
                for a in defs {
                    if let dict = a as? [String: String] {
                        let player = Character(name: dict["Name"], race: dict["Race"], class_: dict["Class"])
                        list.append( player )
                    }
                }
                _savedPlayers = list
                changedPlayers = true
            }
            return _savedPlayers!
        }
        set {
            var arr = [[String: String]]()
            for ch in newValue {
                var dict = [String: String]()
                dict["Name"] = ch.name
                dict["Race"] = ch.race
                dict["Class"] = ch.`class`
                arr.append( dict )
            }
            defaults.setValue( arr as NSArray, forKey: "Players" )
        }
    }
}
