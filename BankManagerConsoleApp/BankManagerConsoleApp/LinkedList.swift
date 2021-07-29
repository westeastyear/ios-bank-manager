//
//  LinkedList.swift
//  BankManagerConsoleApp
//
//  Created by 잼킹 on 2021/07/28.
//

import Foundation

final class LinkedList<T> {
    private final class Node<T> {
        var data: T?
        var next: Node?
        
        init(data: T?, next: Node? = nil) {
            self.data = data
            self.next = next
        }
    }
    
    private var head: Node<T>?
    private var tail: Node<T>?
    
    var isEmpty: Bool {
        return head == nil
    }
    
    var first: T? {
        return head?.data
    }
    
    func addLast(data: T?) {
        if head == nil {
            head = Node(data: data)
            tail = head
            return
        }
        let copiedTail = Node(data: data)
        tail?.next = copiedTail
        tail = copiedTail
    }
    
    func removeFirst() -> T? {
        if head == nil {
            return nil
        }
        let copiedHead = head
        let value = copiedHead?.data
        head = copiedHead?.next
        tail = head
        copiedHead?.next = nil
        return value
    }
    
    func removeAll() {
        head = nil
    }
}
