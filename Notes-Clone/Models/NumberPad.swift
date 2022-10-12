//
//  NumberPad.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 10/10/2022.
//

import UIKit

enum IconType {
    case faceid
    case back
}

enum PadType {
    case number
    case icon
}

struct NumberPad {
    var name: String?
    var image: String?
    var type: PadType
    var iconType: IconType?
    
    static let data = [
        NumberPad(name: "1", image: nil,type: .number,iconType: nil),
        NumberPad(name: "2", image: nil,type: .number,iconType: nil),
        NumberPad(name: "3", image: nil,type: .number,iconType: nil),
        NumberPad(name: "4", image: nil,type: .number,iconType: nil),
        NumberPad(name: "5", image: nil,type: .number,iconType: nil),
        NumberPad(name: "6", image: nil,type: .number,iconType: nil),
        NumberPad(name: "7", image: nil,type: .number,iconType: nil),
        NumberPad(name: "8", image: nil,type: .number,iconType: nil),
        NumberPad(name: "9", image: nil,type: .number,iconType: nil),
        NumberPad(name: nil, image: "faceid",type: .icon,iconType: .faceid),
        NumberPad(name: "0", image: nil,type: .number,iconType: nil),
        NumberPad(name: nil, image: "chevron.left",type: .icon,iconType: .back),
    ]
}
