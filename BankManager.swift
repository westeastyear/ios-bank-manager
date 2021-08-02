//
//  BankManager.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

struct BankManager {
    private enum Menu: String {
        case open = "1"
        case close = "2"
        
        var userInput: String {
            return self.rawValue
        }
    }
    
    private let clerk = Clerk()
    private let customerQueue = Queue<Customer>()
    private var numberOfCustomer: Int {
        return Int.random(in: 10...30)
    }
    
    private func receiveCustomers()  {
        for number in 1...numberOfCustomer {
            customerQueue.enqueue(data: Customer(waitingNumber: number))
        }
    }
    
    func processTask() {
        receiveCustomers()
        var totalCustomer = 0
        while !customerQueue.isEmpty {
            guard let customer = customerQueue.dequeue() else {
                return
            }
            clerk.doTask(customer: Customer(waitingNumber: customer.waitingNumber))
            totalCustomer += 1
        }
        print("업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 \(totalCustomer)명이며, 총 업무시간은 \(Double(totalCustomer) * clerk.businessProcessingTime)초입니다.")
    }
}
