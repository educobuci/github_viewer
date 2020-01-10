//
//  SearchViewControllerSpec.swift
//  GitHubViewerTests
//
//  Created by Eduardo Cobuci on 1/8/20.
//  Copyright © 2020 Eduardo Cobuci. All rights reserved.
//

import Quick
import Nimble
import UIKit

@testable import GitHubViewer

class SearchViewControllerSpec: QuickSpec {
    override func spec() {
        describe("search view controller") {
            var interactor: MockInteractor!
            var controller: SearchViewController!
            var view: SearchView?
            
            beforeEach {
                interactor = MockInteractor()
                controller = SearchViewController()
                controller.interactor = interactor
                view = controller.view as? SearchView
                ViewControllerHelpers.simulateWindow(for: controller)
            }
            
            it("should search for the specified username") {
                view?.searchTextField.text = "dhh"
                view?.searchButton.sendActions(for: .touchUpInside)
                expect(interactor.user) == "dhh"
            }
            
            it("should display an alert with the result") {
                controller.displayMessage(title: "User", message: "Some User")
                expect(controller.presentedViewController as? UIAlertController).toEventuallyNot(beNil())
                let alert = controller.presentedViewController as? UIAlertController
                expect(alert?.title) == "User"
                expect(alert?.message) == "Some User"
                expect(alert?.actions.first?.title) == "OK"
            }
        }
    }
    
    class MockInteractor: SearchInteractorProtocol {
        var user: String?
        
        func search(user: String) {
            self.user = user
        }
    }
}
