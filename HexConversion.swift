//
//  HexConversion.swift
//  WellFit
//
//  Created by Mike on 2015/8/21.
//  Copyright (c) 2015年 Giles. All rights reserved.
//

import Foundation
import UIKit


extension String {
    subscript (index:Int) -> String { return String(Array(self)[index]) }
    // Hexadecimal to Decimal
    var hexaToDecimal: Int {
        var decimal = 0
        if self == "" { return 0 }
        for index in 0..<count(self) {
            for char in 0..<16 {
                if self[index] == "0123456789abcdef"[char] {
                    decimal = decimal * 16 + char
                }
            }
        }
        return self[0] == "-" ? decimal * -1 : decimal
    }
    // Hexadecimal to Binary
    var hexaToBinary: String {
        var decimal = 0
        if self == "" { return "" }
        for index in 0..<count(self){
            for char in 0..<16 {
                if self[index] == "0123456789abcdef"[char] {
                    decimal = decimal * 16 + char
                }
            }
        }
        return String(decimal, radix: 2)
    }
    
    // Decimal to Hexadecimal
    var decimalToHexa: String {
        return String(toInt()!, radix: 16)
    }
    // Decimal to Binary
    var decimalToBinary: String {
        return String(toInt()!, radix: 2)
    }
    
    // Binary to Decimal
    var binaryToDecimal: Int {
        var result = 0
        for index in 0...count(self)-1 {
            if self[index] == "1" { result = result * 2 + 1 }
            if self[index] == "0" { result = result * 2 + 0 }
        }
        return result
    }
    // Binary to Hexadecimal
    var binaryToHexa: String {
        return String(binaryToDecimal, radix: 16)
    }
}

extension Int {
    // Decimal to Binary
    var toBinary: String {
        return String(self, radix: 2)
    }
    // Decimal to Hexadecimal
    var toHexa: String {
        return String(self, radix: 16)
    }
}

/* 例子
println("7fffffffffffffff".hexaToDecimal) // maximum Integer Value  =  2^63 -1  =  9,223,372,036,854,775,807 decimal (Int)
println("7fffffffffffffff".hexaToBinary) // "111111111111111111111111111111111111111111111111111111111111111" binary (String)

println("255".decimalToHexa)   // "ff"       hexa (String)
println("255".decimalToBinary) // "11111111" binary (String)

println("11111111".binaryToHexa)    // "ff"  hexa (String)
println("11111111".binaryToDecimal) // 255 decimal (Int)

println(255.toBinary) // "11111111" binary (String)
println(255.toHexa)   // "ff"       hexadecimal (String)

*/






extension UInt {
    init?(_ string: String, radix: UInt) {
        let digits = "0123456789abcdefghijklmnopqrstuvwxyz"
        var result = UInt(0)
        for digit in string.lowercaseString {
            if let range = digits.rangeOfString(String(digit)) {
                let val = UInt(distance(digits.startIndex, range.startIndex))
                if val >= radix {
                    return nil
                }
                result = result * radix + val
            } else {
                return nil
            }
        }
        self = result
    }
}

/* 例子
let hexString = "252"
if let num = UInt(hexString, radix: 8) {
println(num)
} else {
println("invalid input")
*/



class HexConversion {
    
    //十进制 -> 二进制
    class func turn2to10(inputerNSnumber: String) ->String{
        var str = ""
        var number:Int = inputerNSnumber.toInt()!
        while number > 0 {
            str = "\(number % 2)" + str
            number /= 2
        }
        return str
        
    }
    
    //二進制轉十進制
    class func trun10to2(inpuuterNumber:String) ->String{
        var sum = 0
        
        for c in inpuuterNumber {
            sum = sum * 2 + "\(inpuuterNumber)".toInt()!
        }
        return "\(sum)"
        
    }
    
    //十进制 -> 十六进制
    class func trun10to16(num:String) ->String{
        return String().stringByAppendingFormat("%x",num.toInt()!)
    }
    
    //十进制 -> 8进制
    class func trun10to8(num:String) -> String{
        return String().stringByAppendingFormat("%o",num.toInt()!)
        
    }
    

    
    
    
    //10進制轉 2進制
    class func dec2bit(var number:Int) -> String {
        var str = ""
        while number > 0 {
            // 累加二进制的个位
            str = "\(number & 1)" + str
            // 向左移位去掉个位
            number = number >> 1
            
            
        }
        return str
    }
    
    //16進制轉10進制 6位數
    class func bit16to10digits6(b1:String) -> Int {
        var b1String:String = b1.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        var b1Value:UInt32 = 0
        
        NSScanner(string: b1String).scanHexInt(&b1Value)
        
        var b3Int = (b1Value & 0xFF0000) >> 16
        var b2Int = (b1Value & 0x00FF00)
        var b1Int = (b1Value & 0x0000FF) << 16
        var b4Int = (b1Int | b2Int | b3Int )
        
        return Int(b4Int)
        
    }
    
    //16進制轉10進制 4位數
    class func bit16to10digits4(b1:String) ->Int{
        var b1String:String = b1.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        var b1Value:UInt32 = 0
        
        NSScanner(string: b1String).scanHexInt(&b1Value)
        
        var b2Int:UInt32 = (b1Value & 0x00FF) << 8 //位移8位
        var b1Int:UInt32 = b1Value & 0xFF00 >> 8
        var b3Int:UInt32 = (b2Int | b1Int)
        
        return Int(b3Int)
        
    }
    
    //16進制轉10進制 2位數
    class func bit16todigits2(b1:String) ->Int{
        var b1String:String = b1.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        var b1Value:UInt32 = 0
        NSScanner(string: b1String).scanHexInt(&b1Value)
        var b1Int :UInt32 = b1Value & 0xFF
        return Int(b1Int)
    }
    
    
    class func check4Value(inputValue:Int) ->String {
        
        var checkValue :String =  String(format: "%d",inputValue)
        
        if count(checkValue) == 1{
            
            checkValue = "000" + checkValue
        }else  if count(checkValue) == 2{
            checkValue = "00" + checkValue
        }else  if count(checkValue) == 3{
            checkValue = "0" + checkValue
        }
        
        return checkValue
        
    }
    
    class func check6Value(inputValue:Int) ->String {
        
        var checkValue :String =  String(format: "%d",inputValue)
        
        if count(checkValue) == 1{
            checkValue = "00000" + checkValue
        }else  if count(checkValue) == 2{
            checkValue = "0000" + checkValue
        }else  if count(checkValue) == 3{
            checkValue = "000" + checkValue
        }else  if count(checkValue) == 4{
            checkValue = "00" + checkValue
        }else  if count(checkValue) == 5{
            checkValue = "0" + checkValue
        }
        return checkValue
        
    }
    
    class func check2Value(inputValue:Int) ->String {
        
        var checkValue :String =  String(format: "%d",inputValue)
        
        if count(checkValue) == 1{
            
            checkValue = "0" + checkValue
        }
        
        return checkValue
        
    }
    
    
    class func check8Value(inputValue:String) ->String {
        var  checkValue = inputValue
        
        if count(inputValue) == 7{
            checkValue = "0" + checkValue
        }else if count(inputValue) == 6{
            
            checkValue = "00" + checkValue
        }else if count(inputValue) == 5{
            
            checkValue = "000" + checkValue
        }else if count(inputValue) == 4{
            
            checkValue = "0000" + checkValue
        }else if count(inputValue) == 3{
            
            checkValue = "00000" + checkValue
        }else if count(inputValue) == 2{
            
            checkValue = "000000" + checkValue
        }else if count(inputValue) == 1{
            
            checkValue = "000000" + checkValue
        }
        
        return checkValue
        
    }
    
    
  }
