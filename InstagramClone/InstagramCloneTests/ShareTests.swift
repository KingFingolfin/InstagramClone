//
//  ShareTests.swift
//  InstagramCloneTests
//
//  Created by Giorgi on 25.11.24.
//

import XCTest
@testable import InstagramClone

final class ShareTests: XCTestCase {
    let vc = ShareBottomSheetViewController()
    
    func testIfLablesEmpty() throws {
        let lables = vc.actionTitles
        XCTAssertNotNil(lables)
    }
    
    func testIfIconsEmpty() throws {
        let icons = vc.actionIcons
        XCTAssertNotNil(icons)
    }

}
