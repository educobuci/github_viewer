//
//  ApplicationFactorySpec.swift
//  GitHubViewerTests
//
//  Created by Eduardo Cobuci on 1/9/20.
//  Copyright © 2020 Eduardo Cobuci. All rights reserved.
//

import Quick
import Nimble
import UIKit

@testable import GitHubViewer

class ApplicationFactorySpec: QuickSpec {
    override func spec() {
        describe("application factory") {
            it("should create the root view-controller") {
                let factory = ApplicationFactory()
                let rootViewController: UINavigationController = factory.createRootViewController()
                let searchViewController = rootViewController.viewControllers.first as? SearchViewController
                expect(searchViewController?.interactor).toNot(beNil())
            }
        }
    }
}
