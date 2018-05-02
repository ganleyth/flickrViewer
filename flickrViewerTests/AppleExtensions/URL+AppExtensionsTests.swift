//
//  URL+AppExtensionsTests.swift
//  flickrViewerTests
//
//  Created by Thomas Ganley on 5/1/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import XCTest
@testable import flickrViewer

class URL_AppExtensionsTests: XCTestCase {
    
    func testAppendingURLParameters() {
        guard let baseURL = URL(string: "https://google.com") else { XCTFail(); return }
        let params = ["key0": "param0",
                      "key1": "param1",
                      "key2": "param2"]
        
        let url = baseURL.appendingParameters(params)
        
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems else { XCTFail(); return }
        var appendedParams = [String: String]()
        queryItems.forEach { appendedParams[$0.name] = $0.value }
        
        XCTAssertEqual(params, appendedParams)
    }
}
