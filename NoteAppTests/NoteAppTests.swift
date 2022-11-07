//
//  NoteAppTests.swift
//  NoteAppTests
//
//  Created by Kwame Agyenim - Boateng on 07/11/2022.
//

import XCTest
@testable import NoteApp

class NoteAppTests: XCTestCase {

    func testCapitalizeFirstLetter(){
        let input = "note"
        let expectedOutput = "Note"
        
        XCTAssertEqual(input.capitalizeFirstLetter(), expectedOutput, "string not correctly capitalized")
        
    }
    func testNameInitials(){
        let inputName = "kwame boateng"
        let outputName = "KB"
        
        XCTAssertEqual(inputName.getUserInitials(), outputName, "wrong user full name initials")
    }
    
}
