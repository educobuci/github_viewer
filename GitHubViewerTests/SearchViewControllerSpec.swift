//
//  SearchViewControllerSpec.swift
//  GitHubViewerTests
//
//  Created by Eduardo Cobuci on 1/8/20.
//  Copyright © 2020 Eduardo Cobuci. All rights reserved.
//

import Quick
import Nimble

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
            }
            
            it("should search for the specified username") {
                view?.searchTextField.text = "dhh"
                view?.searchButton.sendActions(for: .touchUpInside)
                expect(interactor.term) == "dhh"
            }
            
            it("should display an alert with the result") {
                
            }
        }
    }
    
    class MockInteractor: SearchInteractorProtocol {
        var term: String?
        
        func search(term: String) {
            self.term = term
        }
    }
}
