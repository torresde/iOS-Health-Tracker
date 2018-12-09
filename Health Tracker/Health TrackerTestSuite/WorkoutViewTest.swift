//
//  WorkoutViewTest.swift
//  Health TrackerTestSuite
//
//  Created by Naveen Varadharaj on 12/9/18.
//  Copyright © 2018 CS4278FinalProject. All rights reserved.
//

import Foundation

import XCTest
@testable import Health_Tracker

class WorkoutViewTest: XCTestCase {
    
    var sut: WorkoutViewController!
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
        sut = (storyboard.instantiateViewController(withIdentifier: "workoutView") as! WorkoutViewController)
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    class CheckWorkoutNameLoaded {
        var workoutNameLoaded = true
    }
    
    func testWorkoutViewLoaded() {
        let isLoaded = CheckWorkoutNameLoaded()
        
        loadView()
        
        XCTAssertTrue(isLoaded.workoutNameLoaded)
        
    }
}
