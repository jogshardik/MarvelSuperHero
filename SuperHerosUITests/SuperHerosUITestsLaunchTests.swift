import XCTest

class SuperHerosUITestsLaunchTests: XCTestCase {
    func test_recordCharacterDetail() {
        let app = XCUIApplication()
        app.launch()
        app.tables.cells.containing(.staticText, identifier: "3-D Man").children(matching: .other).element(boundBy: 1).tap()
        sleep(4)
        app.navigationBars["3-D Man"].buttons["Marvel Heros"].tap()
    }
}
