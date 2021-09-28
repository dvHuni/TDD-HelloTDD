import XCTest
import Foundation

final class CashRegister {
    var availableFunds: Decimal
    var transactionTotal: Decimal = 0
    
    init(availableFunds: Decimal) {
        self.availableFunds = availableFunds
    }
    
    func addItem(_ cost: Decimal) {
        transactionTotal += cost
    }
    
    func acceptCashPayment(_ cash: Decimal) {
        transactionTotal -= cash
        availableFunds += cash
    }
}

final class CashRegisterTests: XCTestCase {
    private var availableFunds: Decimal!
    private var itemCost: Decimal!
    private var payment: Decimal!
    private var sut: CashRegister!
    
    override func setUp() {
        super.setUp()
        availableFunds = 100
        itemCost = 42
        payment = 10
        sut = CashRegister(availableFunds: availableFunds)
    }
    
    override func tearDown() {
        availableFunds = nil
        itemCost = nil
        payment = nil
        sut = nil
        super.tearDown()
    }
    
    func testInitAvailableFunds_setsAvailableFunds() {
        // then
        XCTAssertEqual(sut.availableFunds, availableFunds)
    }
    
    func testAddItem_oneItem_addsCostToTransactionTotal() {
        // when
        sut.addItem(itemCost)
        
        // then
        XCTAssertEqual(sut.transactionTotal, itemCost)
    }
    
    func testAddItem_twoItems_addsCostsToTransactionTotal() {
        // given
        let itemCost = Decimal(42)
        let itemCost2 = Decimal(20)
        let expectedTotal = itemCost + itemCost2
        
        // when
        sut.addItem(itemCost)
        sut.addItem(itemCost2)
        
        // then
        XCTAssertEqual(sut.transactionTotal, expectedTotal)
    }
    
    func testAcceptCashPayment_subtractsPaymentFromTransactionTotal() {
        // given
        sut.addItem(itemCost)
        let remainCash = sut.transactionTotal - payment
        
        // when
        sut.acceptCashPayment(payment)
        
        // then
        XCTAssertEqual(sut.transactionTotal, remainCash)
    }
}

CashRegisterTests.defaultTestSuite.run()
