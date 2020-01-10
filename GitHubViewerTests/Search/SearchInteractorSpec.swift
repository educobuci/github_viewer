//
//  SearchInteractorSpec.swift
//  GitHubViewerTests
//
//  Created by Eduardo Cobuci on 1/8/20.
//  Copyright © 2020 Eduardo Cobuci. All rights reserved.
//

import Quick
import Nimble
import Combine
import Foundation

@testable import GitHubViewer

class SearchInteractorSpec: QuickSpec {
    
    override func spec() {
        describe("search interactor") {
            var interactor: SearchInteractor!
            var service: MockService!
            var presenter: MockPresenter!
            let user = User(login: "dhh",
                            id: 2741,
                            avatarUrl: "https://avatars0.githubusercontent.com/u/2741?v=4",
                            name: "David Heinemeier Hansson")
            
            beforeEach {
                service = MockService(user: user)
                presenter = MockPresenter()
                interactor = SearchInteractor(service: service, presenter: presenter)
            }
            
            it("should use the service to search for a user and pass to the presenter") {
                interactor.search(user: "dhh")
                expect(presenter.user) == user
            }
            
            context("if a request error occours") {
                it("should pass the error to the presenter") {
                    interactor.search(user: "")
                    expect(presenter.error).toNot(beNil())
                }
            }
        }
    }
    
    class MockService: SearchServiceProtocol {
        let user: User
        
        func search(user: String) -> AnyPublisher<User, Error> {
            if user == "" {
                return Future { $0(.failure(NSError(domain: "Test", code: 0, userInfo: nil))) }.eraseToAnyPublisher()
            }
            return Future { $0(.success(self.user)) }.eraseToAnyPublisher()
        }
        
        init(user: User) {
            self.user = user
        }
    }
    
    class MockPresenter: SearchPresenterProtocol {
        var user: User?
        var error: Error?
        
        func present(user: User) {
            self.user = user
        }
        
        func onError(error: Error) {
            self.error = error
        }
    }
}
