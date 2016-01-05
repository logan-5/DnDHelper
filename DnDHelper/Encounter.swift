//
//  Encounter.swift
//  DnDHelper
//
//  Created by Logan Smith on 1/2/16.
//  Copyright © 2016 Logan Smith. All rights reserved.
//

import Foundation

struct Encounter {

    struct Participant {
        var character: Character
        let initiative: Int
        init( character: Character, initiative: Int ) {
            self.character = character
            self.initiative = initiative
        }
    }

    var participants = [Participant]() {
        didSet {
            if participants.count != participantCount {
                participantCount = participants.count
                participants.sortInPlace({ $0.initiative > $1.initiative })
            }
        }
    }
    var participantCount: Int = 0
}