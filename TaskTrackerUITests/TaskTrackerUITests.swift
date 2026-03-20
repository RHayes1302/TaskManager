//
//  TaskTrackerUITests.swift
//  TaskTrackerUITests
//
//  Created by Ramone Hayes on 3/3/26.
//

import XCTest

final class TaskTrackerUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments += ["-AppleLocale", "en_US"]
    }
    
    override func tearDownWithError() throws {
        app.terminate()
    }
    
    func testLaunchInEnglish() throws {
        app.launchArguments = ["-AppleLanguages", "(en)"]
        app.launch()
        
        let englishHeader = app.staticTexts["Who is Working Today?"]
        XCTAssertTrue(englishHeader.exists, "The header should be in English, text incorrect or not found")
    }
    
    func testLaunchInSpanish() throws {
        app.launchArguments = ["-AppleLanguages", "(es-US)"]
        app.launch()
        
        let spanishHeader = app.staticTexts["¿Quién trabaja hoy?"]
        XCTAssertTrue(spanishHeader.exists, "The header should be in Spanish, text incorrect or not found")
    }
    
    func testLaunchInItalian() throws {
        app.launchArguments = ["-AppleLanguages", "(it)"]
        app.launch()
        
        let italianHeader = app.staticTexts["Chi lavora oggi?"]
        XCTAssertTrue(italianHeader.exists, "The header should be in Italian, text incorrect or not found")
    }
    
    func testLaunchInFrench() throws {
        app.launchArguments = ["-AppleLanguages", "(fr-CA)"]
        app.launch()
        
        let frenchHeader = app.staticTexts["Qui travaille aujourd'hui?"]
        XCTAssertTrue(frenchHeader.exists, "The header should be in French, text incorrect or not found")
    }
    
    func testLaunchInHebrew() throws {
        app.launchArguments = ["-AppleLanguages", "(he)"]
        app.launch()
        
        let hebrewHeader = app.staticTexts["מי עובד היום?"]
        XCTAssertTrue(hebrewHeader.exists, "The header should be in Hebrew, text incorrect or not found")
    }
    
}
