//
//  GitHubService.swift
//  GitHubViewerTests
//
//  Created by Eduardo Cobuci on 1/8/20.
//  Copyright © 2020 Eduardo Cobuci. All rights reserved.
//

import Quick
import Nimble
import Foundation
import Combine

@testable import GitHubViewer

class GitHubServiceSpec: QuickSpec {
    override func spec() {
        describe("github service") {
            var service: GitHubService!
            
            let userDhh = User(login: "dhh",
                               id: 2741,
                               avatarUrl: "https://avatars0.githubusercontent.com/u/2741?v=4",
                               name: "David Heinemeier Hansson")
            
            let userDudu = User(login: "educobuci",
                                id: 72661,
                                avatarUrl: "https://avatars1.githubusercontent.com/u/72661?v=4",
                                name: "Eduardo Cobuci")
            
            var session: URLSession!
            var decoder: MockDecoder!
            var cancellable: Cancellable?
            
            beforeEach {
                decoder = MockDecoder(users: ["dhh": userDhh, "educobuci": userDudu])
                let config = URLSessionConfiguration.ephemeral
                config.protocolClasses = [MockProtocol.self]
                MockProtocol.testURLs = [
                    URL(string: "https://api.github.com/users/dhh"): Data("dhh".utf8),
                    URL(string: "https://api.github.com/users/educobuci"): Data("educobuci".utf8)
                ]
                session = URLSession(configuration: config)
                service = GitHubService(session: session, decoder: decoder)
            }
            
            it("should implement the search service") {
                waitUntil { done in
                    cancellable = service.search(user: "dhh").sink(receiveCompletion: { result in }) { userResult in
                        expect(userResult) == userDhh
                        done()
                    }
                    expect(cancellable).toNot(beNil())
                }
            }
            
            it("should retreive the user json representation from the api client and decode it") {
                waitUntil { done in
                    cancellable = service.search(user: "educobuci").sink(receiveCompletion: { result in }) { userResult in
                        expect(userResult) == userDudu
                        done()
                    }
                    expect(cancellable).toNot(beNil())
                }
            }
            
            it("should return an error if the user is not found") {
                waitUntil { done in
                    cancellable = service.search(user: "").sink(receiveCompletion: { result in
                        switch result {
                        case .failure(let error):
                            expect(error as? SearchError) == .notFound
                        default:
                            fail()
                        }
                        done()
                    }, receiveValue: { user in })
                    expect(cancellable).toNot(beNil())
                }
            }
        }
    }
    
    class MockDecoder: DataDecoderProtocol {
        let users: [String: User]
        
        init(users: [String: User]) {
            self.users = users
        }
        
        func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
            let user = String(data: data, encoding: .utf8)!
            return users[user] as! T
        }
    }
}
