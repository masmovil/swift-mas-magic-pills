import MasMagicPills
import UIKit
import XCTest

private class HomeViewController: UIViewController {}
private class SecondViewController: UIViewController {}

class UIViewControllerExtensionsTests: XCTestCase {
    func test_pop_viewcontroller() {
        let navigationController = UINavigationController()
        let homeViewController = HomeViewController()
        navigationController.viewControllers = [homeViewController]
        let secondViewController = SecondViewController()
        navigationController.pushViewController(secondViewController, animated: false)
        secondViewController.viewDidAppear(false)
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertTrue(navigationController.visibleViewController is SecondViewController)
        secondViewController.popView(animated: false)
        XCTAssertEqual(navigationController.viewControllers.count, 1)
        XCTAssertTrue(navigationController.visibleViewController is HomeViewController)
    }
}
