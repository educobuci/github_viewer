//
//  ViewControllerHelper.swift
//  GitHubViewerTests
//
//  Created by Eduardo Cobuci on 1/8/20.
//  Copyright © 2020 Eduardo Cobuci. All rights reserved.
//

import UIKit

class ViewControllerHelpers {
    static func simulateWindow(for viewController: UIViewController) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        viewController.view.layoutIfNeeded()
    }
}
