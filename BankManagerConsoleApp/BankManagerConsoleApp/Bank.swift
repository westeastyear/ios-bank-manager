//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by musun129 on 2021/04/30.
//

import Foundation

class Bank {
    var counters: [Teller] = []
    let customerQueue: CustomerQueue = CustomerQueue(name: "고객 대기열")
    let notificationBoard: NotificationBoard = NotificationBoard()

    class NotificationBoard {
        var observers: [CustomerQueue] = []
        
        func addObserver(_ observer: CustomerQueue) {
            observers.append(observer)
        }
        
        func removeObserver(_ observer: CustomerQueue) {
            observers.removeAll(where: { $0.name == observer.name })
        }
        
        func call(by teller: Teller) {
            floatOnBoard(by: teller)
        }
        
        func floatOnBoard(by teller: Teller) {
            for index in 0..<observers.count {
                guard let customer = observers[index].dequeue() else { continue }
                customer.go(to: teller, by: self)
            }
        }
    }
    
    class Teller {
        let counterNumber: Int
        static let taskingTime: Double = 0.7
        
        init(counterNumber: Int) {
            self.counterNumber = counterNumber
        }
        
        func work(forCustomerOf waitingNumber: Int, by notificationBoard: NotificationBoard) {
            print("\(waitingNumber)번 고객 업무 시작")
            usleep(useconds_t(Int(Teller.taskingTime * 1_000_000)))
            print("\(waitingNumber)번 고객 업무 완료")
            call(to: notificationBoard)
        }
        
        func call(to notificationBoard: NotificationBoard) {
            notificationBoard.call(by: self)
        }
    }

    struct CustomerQueue {
        private var queue: [Customer] = []
        let name: String

        init(name: String) {
            self.name = name
        }

        mutating func enqueue(customer: Customer) {
            queue.append(customer)
        }

        mutating func dequeue() -> Customer? {
            return queue.removeFirst()
        }
    }

    class Customer {
        let waitingNumber: Int

        init(waitingNumber: Int) {
            self.waitingNumber = waitingNumber
        }

        func go(to teller: Teller, by notificationBoard: NotificationBoard) {
            teller.work(forCustomerOf: self.waitingNumber, by: notificationBoard)
        }
    }
}
