import XCTest

class MeLiTestUITests: XCTestCase {
        
    var app: XCUIApplication!
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        app = XCUIApplication()
        
        // We send a launch argument to our app,
        // to let us know it is UITesting
        app.launchArguments.append("--uitesting")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCompleteFlow(){
        
        app.launch()

        let navigationBar = app.navigationBars.firstMatch
        
        app.buttons["Comenzar"].tap()
        
        let amountTextField = app.textFields.firstMatch
        amountTextField.typeText("400")
        
        navigationBar.buttons["Siguiente"].tap()
        
        let creditCardCell = app.tables.cells.staticTexts["Tarjeta 1"]
        let creditCardCellExists = creditCardCell.waitForExistence(timeout: 2)
        XCTAssert(creditCardCellExists, "Credit card cell not showing")
        creditCardCell.tap()
        
        navigationBar.buttons["Siguiente"].tap()
        
        let bankCell = app.tables.cells.staticTexts["Banco 1"]
        let bankCellExists = bankCell.waitForExistence(timeout: 2)
        XCTAssert(bankCellExists, "Bank cell not showing")
        bankCell.tap()
        
        navigationBar.buttons["Siguiente"].tap()
        
        let installmentCell = app.tables.cells.staticTexts["1 cuota de $400"]
        let installmentCellExists = installmentCell.waitForExistence(timeout: 2)
        XCTAssert(installmentCellExists, "Installment cell not showing")
        installmentCell.tap()
        
        navigationBar.buttons["Finalizar"].tap()
        
        let flowEndAlert = app.alerts.firstMatch
        let flowEndAlertExists = flowEndAlert.waitForExistence(timeout: 2)
        XCTAssert(flowEndAlertExists, "Completion alert not showing")

        
    }
    
}
