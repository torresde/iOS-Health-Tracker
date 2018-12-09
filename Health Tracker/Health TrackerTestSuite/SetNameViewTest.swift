//
//  SetNameViewTest.swift
//  Health TrackerTestSuite
//
//  Created by Naveen Varadharaj on 12/9/18.
//  Copyright © 2018 CS4278FinalProject. All rights reserved.
//

import Foundation

import XCTest
@testable import Health_Tracker

class SetNameViewTest: XCTestCase {
    
    var sut: SetNameViewController!
    var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupWorkoutViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    func setupWorkoutViewController () {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = (storyboard.instantiateViewController(withIdentifier: "setNameView") as! SetNameViewController)
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    class CheckSetNameViewLoaded {
        var setNameViewLoaded = true
    }
    
    func testSetNameViewLoaded() {
        let isLoaded = CheckSetNameViewLoaded()
        
        loadView()
        
        XCTAssertTrue(isLoaded.setNameViewLoaded)
        
    }
}
