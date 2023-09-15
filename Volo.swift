//
//  File.swift
//  printtest
//
//  Created by mtrec_mbp on 14/9/2023.
//

import Foundation
import printtest.CppBridge


public class Volo{
    public init() { } // 显式定义一个 public 的构造器
    public func sayHello(){
        printHelloWorldFromCppBridge()
    }
}
