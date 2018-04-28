//
//  PhotoTests.swift
//  flickrViewerTests
//
//  Created by Thomas Ganley on 4/27/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import XCTest
@testable import flickrViewer

class PhotoTests: XCTestCase {
    
    func testDecodingPhotos() {
        let bundle = Bundle(for: type(of: self))
        guard let sampleDataPath = bundle.path(forResource: "SampleSearchResponse", ofType: "json") else { XCTFail(); return }
        
        let photos: [Photo]
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: sampleDataPath))
            let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
            photos = searchResponse.photos
        } catch {
            XCTFail(error.localizedDescription)
            return
        }
        
        let expectedPhoto0 = Photo(id: "26878581007",
                                  title: "IMG_5389",
                                  farmID: 1,
                                  serverID: "827",
                                  secret: "65f983b4b7")
        
        let expectedPhoto1 = Photo(id: "40847624005",
                                   title: "IMG_5391",
                                   farmID: 1,
                                   serverID: "832",
                                   secret: "314de79c7d")
        
        let expectedPhoto2 = Photo(id: "41705966022",
                                   title: "IMG_5406",
                                   farmID: 1,
                                   serverID: "959",
                                   secret: "ccc458819f")
        
        XCTAssertEqual(expectedPhoto0, photos[0])
        XCTAssertEqual(expectedPhoto1, photos[1])
        XCTAssertEqual(expectedPhoto2, photos[2])
    }
}
