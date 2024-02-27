//
//  UIImageViewExtensionTests.swift
//  GamifyAssigmentTests
//
//  Created by Atul Sharan on 27/02/24.
//

import Foundation
import XCTest
@testable import GamifyAssigment

class UIImageViewExtensionTests: XCTestCase {
    
    var imageView: UIImageView!
    
    override func setUp() {
        super.setUp()
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
    }
    
    override func tearDown() {
        imageView = nil
        super.tearDown()
    }
    
    func testValidURL() {
        imageView.downloadImage(from: "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg", contentMode: .scaleAspectFill)
        // You may need to wait for the download to complete before asserting
        // Assert the result based on the download completion
    }
    
    func testInvalidURL() {
        imageView.downloadImage(from: "invalidURL", contentMode: .scaleAspectFill)
        // Assert that imageView remains unchanged
    }
    
    func testCachedImage() {
        let cachedURL = URL(string: "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg")!
        UIImageView.imageCache.setObject(UIImage(named: "20aa03a10cda45239fe22d035c0ebe64.jpg") ?? UIImage(), forKey: cachedURL.absoluteString as NSString)
        
        imageView.downloadImage(from: cachedURL, contentMode: .scaleAspectFill)
        // Assert that imageView displays the cached image
    }
    
    func testDownloadingImageAsynchronously() {
        imageView.downloadImage(from: "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg", contentMode: .scaleAspectFill)
        // You may need to wait for the download to complete before asserting
        // Assert the result based on the download completion
    }
    
    func testSettingContentMode() {
        imageView.downloadImage(from: "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg", contentMode: .scaleAspectFill)
        XCTAssertEqual(imageView.contentMode, .scaleAspectFill)
    }
}
