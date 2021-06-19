//
//  Message.swift
//  Flash Chat iOS13
//
//  Created by Guilherme de Assis dos Santos on 16/06/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation

struct Message {
    let sender: String // email
    let body: String
    var destination: String? // email tbm
}
