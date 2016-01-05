//
//  Character.swift
//  DnDHelper
//
//  Created by Logan Smith on 1/2/16.
//  Copyright © 2016 Logan Smith. All rights reserved.
//

import Foundation

struct Character {
    let name: String?
    let race: String?
    let `class`: String?
    var descriptionString: String {
        get {
            var description = ""
            if let r = self.race {
                description = r + " "
            }
            if let c = self.`class` {
                description += c
            }
            return description
        }
    }

    var hp: Int?
    var maxHp: Int?
    var dead = false
    var npc = false

    init( name: String?, race: String?, class_: String?, npc: Bool = false, hp: Int = 0 ) {
        self.name = name
        self.race = race
        self.`class` = class_
        self.npc = npc
        self.hp = hp
        self.maxHp = hp
    }

    mutating func hit( damage: Int ) {
        hp = max( 0, hp! - damage )
    }
}

struct CharacterData {
    static var players = Data.sharedData.savedPlayers {
        didSet {
            Data.sharedData.savedPlayers = players
        }
    }
}
