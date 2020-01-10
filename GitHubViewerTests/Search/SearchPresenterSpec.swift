//
//  SearchPresenterSpec.swift
//  GitHubViewerTests
//
//  Created by Eduardo Cobuci on 1/9/20.
//  Copyright © 2020 Eduardo Cobuci. All rights reserved.
//

import Quick
import Nimble
import Foundation

@testable import GitHubViewer

class SearchPresenterSpec: QuickSpec {
    override func spec() {
        describe("search presenter") {
            var presenter: SearchPresenter!
            var view: MockView!
            let userDhh = User(login: "dhh", id: 1, avatarUrl: "", name: "David Heinemeier Hansson")
            
            beforeEach {
                view = MockView()
                presenter = SearchPresenter(view: view)
            }
            
            it("should present the user name onto the view") {
                presenter.present(user: userDhh)
                expect(view.title) == userDhh.login
                expect(view.message) == userDhh.name
            }
            
            context("if the user was not found") {
                it("should present an user-not-found message onto the view") {
                    presenter.onError(error: SearchError.notFound)
                    expect(view.title) == "Error"
                    expect(view.message) == "User not found"
                }
            }
            
            context("if an unknown error accours") {
                it("should present an unknown-error message onto the view") {
                    presenter.onError(error: NSError())
                    expect(view.title) == "Error"
                    expect(view.message) == "An unknown error has occurred"
                }
            }
            
        }
    }
    
    class MockView: SearchViewProtocol {
        var title: String?
        var message: String?
        
        func displayMessage(title: String, message: String) {
            self.title = title
            self.message = message
        }
    }
}
