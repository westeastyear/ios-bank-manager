//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by 예거 on 2021/12/23.
//

import Foundation

class Bank {
    
    var delegate: BankDelegate?
    private var clientQueue = Queue<Client>()
    
    func lineUp(_ client: Client) {
        clientQueue.enqueue(client)
    }
    
    func start() {
        var clientCount: Int = .zero
        var workingDuration: Double = .zero
        while true {
            guard let client = clientQueue.dequeue() else {
                delegate?.bankDidClose(totalClient: clientCount,
                                       for: workingDuration.roundedOff)
                return
            }
            service(client)
            clientCount += 1
            workingDuration += Task.deposit.duration
        }
    }
    
    private func service(_ client: Client) {
        delegate?.bank(willBeginServiceFor: client.waitingNumber)
        client.task.work()
        delegate?.bank(didEndServiceFor: client.waitingNumber)
    }
}
