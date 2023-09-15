//
//  volTests.swift
//  printtestTests
//
//  Created by mtrec_mbp on 15/9/2023.
//

import XCTest
@testable import printtest

class VoloTests: XCTestCase {

    func testSayHello() {
        // 创建一个 expectation 对象，用于异步测试
        let expectation = self.expectation(description: "expectation")

        // 重定向标准输出
        let originalStdout = dup(STDOUT_FILENO)
        let pipe = Pipe()
        dup2(pipe.fileHandleForWriting.fileDescriptor, STDOUT_FILENO)

        // 创建一个 Volo 对象并调用 sayHello
        let volo = Volo()
        volo.sayHello()

        // 读取重定向的输出
        pipe.fileHandleForReading.readToEndOfFileInBackgroundAndNotify()

        // 当读取完成时，验证输出
        var observer: NSObjectProtocol!
        observer = NotificationCenter.default.addObserver(forName: NSNotification.Name.NSFileHandleReadToEndOfFileCompletion, object: pipe.fileHandleForReading, queue: nil) { notification in
            defer {
                NotificationCenter.default.removeObserver(observer)
                dup2(originalStdout, STDOUT_FILENO)
            }

            let data = notification.userInfo![NSFileHandleNotificationDataItem] as! Data
            let output = String(data: data, encoding: .utf8)

            // 验证输出是否包含 "Hello World"
            XCTAssertTrue(output?.contains("Hello World") ?? false)

            // 标记 expectation 为已完成
            expectation.fulfill()
        }

        // 等待 expectation 完成，或超时（在这里设置为 5 秒）
        waitForExpectations(timeout: 5, handler: nil)
    }

}
