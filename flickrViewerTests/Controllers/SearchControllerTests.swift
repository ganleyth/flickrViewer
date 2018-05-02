//
//  SearchControllerTests.swift
//  flickrViewerTests
//
//  Created by Thomas Ganley on 5/1/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import XCTest
@testable import flickrViewer

class SearchControllerTests: XCTestCase {
    
    func testURLBuilderAddsAppropriateParameters() {
        let searchTerm = "test"
        guard let endPointPlusParams = SearchController.buildURLFor(searchTerm: searchTerm, page: 3) else {
            XCTFail("The method under test, itself, failed.")
            return
        }
        guard
            let components = URLComponents(url: endPointPlusParams, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems else { XCTFail(); return }
        
        var params = [String: String]()
        
        queryItems.forEach { params[$0.name] = $0.value }
        
        XCTAssertEqual(params[Constants.FlickrAPI.apiKeyKey], Constants.FlickrAPI.apiKey)
        XCTAssertEqual(params[Constants.FlickrAPI.textKey], searchTerm)
        XCTAssertEqual(params[Constants.FlickrAPI.perPageKey], "25")
        XCTAssertNotNil(Int(params[Constants.FlickrAPI.pageKey] ?? "fail"))
    }
}
