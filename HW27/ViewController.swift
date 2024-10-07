//
//  ViewController.swift
//  HW27
//
//  Created by Максим Громов on 07.10.2024.
//

import UIKit
class BankAccount {
    var balance: Double = 0
    let lock = NSLock()
    func deposit(_ amount: Double) {
        lock.lock()
        balance += amount
        lock.unlock()
    }
    func withdraw(_ amount: Double) {
        lock.lock()
        balance -= amount
        lock.unlock()
    }
}
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let thread = Thread {
            print("Hello from another thread")
        }
        thread.start()
        
        let queue = DispatchQueue(label: "com.gm.queue", attributes: .concurrent)
        var acc1 = BankAccount()
        var acc2 = BankAccount()
        queue.sync {
            acc1.deposit(100)
            acc1.withdraw(50)
            acc1.withdraw(25)
            acc2.deposit(10)
            acc1.deposit(5)
            acc2.deposit(20)
            acc2.withdraw(5)
        }
        if acc1.balance != 30{
            print("Беда1")
        }
        if acc2.balance != 25{
            print("Беда2")
        }
        
        
    }


}

