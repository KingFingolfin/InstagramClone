//
//  SearchPageTests.swift
//  InstagramCloneTests
//
//  Created by Giorgi on 25.11.24.
//

import XCTest
@testable import InstagramClone

final class SearchPageTests: XCTestCase {
    let vc = SearchViewController()
    
    func testSearchBarPlaceholder() throws {
        let placeholder = vc.searchBar
        XCTAssertEqual(placeholder.placeholder, vc.searchBar.placeholder)
    }
    
    func testUserImageView() throws {
        let image = vc.userImageView
        XCTAssertEqual(image.layer.cornerRadius, 30)
    }
}
