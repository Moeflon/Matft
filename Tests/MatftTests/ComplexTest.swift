//
//  ComplexTest.swift
//  
//
//  Created by Junnosuke Kado on 2022/07/04.
//

import XCTest
//@testable import Matft
import Matft

import Accelerate

final class ComplexTests: XCTestCase {
    
    func test_complex() {
        do {
            let real = Matft.arange(start: 0, to: 16, by: 1).reshape([2,2,4])
            let imag = Matft.arange(start: 0, to: -16, by: -1).reshape([2,2,4])
            let a = MfArray(real: real, imag: imag)
            
            XCTAssertEqual(a.real, real)
            XCTAssertEqual(a.imag!, imag)
        }
    }
    
    func testArithmetic() {
        do {
            let real = Matft.arange(start: 0, to: 16, by: 1).reshape([2,2,4])
            let imag = Matft.arange(start: 0, to: -16, by: -1).reshape([2,2,4])
            let a = MfArray(real: real, imag: imag)
            
            var ret = a + a
            XCTAssertEqual(ret.real, real+real)
            XCTAssertEqual(ret.imag, imag+imag)
            XCTAssertEqual(ret, MfArray(real: real+real, imag: imag+imag))
            
            ret = a - a
            XCTAssertEqual(ret.real, real-real)
            XCTAssertEqual(ret.imag, imag-imag)
            XCTAssertEqual(ret, MfArray(real: real-real, imag: imag-imag))
            
            ret = a * a
            XCTAssertEqual(ret.real, MfArray([[[0, 0, 0, 0],
                                               [0, 0, 0, 0]],

                                              [[0, 0, 0, 0],
                                               [0, 0, 0, 0]]]))
            XCTAssertEqual(ret.imag, MfArray([[[   0,   -2,   -8,  -18],
                                               [ -32,  -50,  -72,  -98]],

                                              [[-128, -162, -200, -242],
                                               [-288, -338, -392, -450]]]))
            
            
        }
        
        do{
            let real = Matft.arange(start: 0, to: 16, by: 1).reshape([2,2,4])
            let imag = Matft.arange(start: 0, to: -16, by: -1).reshape([2,2,4])
            let a = MfArray(real: real, imag: imag)
            
            var ret = a + 3
            XCTAssertEqual(ret.real, real+3)
            XCTAssertEqual(ret.imag, imag)
            XCTAssertEqual(ret, MfArray(real: real+3, imag: imag))
            
            ret = a - 3
            XCTAssertEqual(ret.real, real-3)
            XCTAssertEqual(ret.imag, imag)
            XCTAssertEqual(ret, MfArray(real: real-3, imag: imag))
            
            ret = a * -2
            XCTAssertEqual(ret.real, real * -2)
            XCTAssertEqual(ret.imag, imag * -2)
            XCTAssertEqual(ret, MfArray(real: real * -2, imag: imag * -2))
            
            ret = a / 3
            XCTAssertEqual(ret.real, real / 3)
            XCTAssertEqual(ret.imag, imag / 3)
            XCTAssertEqual(ret, MfArray(real: real / 3, imag: imag / 3))
        }
    }
    
    func testAngle() {
        do {
            let real = Matft.arange(start: 0, to: 16, by: 1).reshape([2,2,4])
            let imag = Matft.arange(start: 0, to: -16, by: -1).reshape([2,2,4])
            let a = MfArray(real: real, imag: imag)
            
            XCTAssertEqual(Matft.complex.angle(a), MfArray([[[ 0.0        , -0.78539816, -0.78539816, -0.78539816],
                                                             [-0.78539816, -0.78539816, -0.78539816, -0.78539816]],

                                                            [[-0.78539816, -0.78539816, -0.78539816, -0.78539816],
                                                             [-0.78539816, -0.78539816, -0.78539816, -0.78539816]]] as [[[Float]]]))
        }
    }
    
    func testConjugate() {
        do{
            let real = Matft.arange(start: 0, to: 16, by: 1).reshape([2,2,4])
            
            XCTAssertEqual(Matft.complex.conjugate(real), real)
        }
        
        do {
            let real = Matft.arange(start: 0, to: 16, by: 1).reshape([2,2,4])
            let imag = Matft.arange(start: 0, to: -16, by: -1).reshape([2,2,4])
            let a = MfArray(real: real, imag: imag)
            let conj = Matft.complex.conjugate(a)
            
            XCTAssertEqual(conj.real, real)
            XCTAssertEqual(conj.imag!, -imag)
        }
    }
    
    func testAstype(){
        do{
            let real = Matft.arange(start: 0, to: 16, by: 1).reshape([2,2,4])
            let imag = Matft.arange(start: 0, to: -16, by: -1).reshape([2,2,4])
            let a = MfArray(real: real, imag: imag)
            let ret = a.astype(.Double)
            
            XCTAssertEqual(ret.real, real.astype(.Double))
            XCTAssertEqual(ret.imag!, imag.astype(.Double))
        }
    }
    
    func testNegative(){
        do{
            let real = Matft.arange(start: 0, to: 16, by: 1).reshape([2,2,4])
            let imag = Matft.arange(start: 0, to: -16, by: -1).reshape([2,2,4])
            let a = MfArray(real: real, imag: imag)
            let ret = -a
            
            XCTAssertEqual(ret.real, -real)
            XCTAssertEqual(ret.imag!, -imag)
        }
    }
    
    func testAbsolute(){
        do{
            let real = Matft.arange(start: 0, to: 16, by: 1).reshape([2,2,4])
            let imag = Matft.arange(start: 0, to: -16, by: -1).reshape([2,2,4])
            let a = MfArray(real: real, imag: imag)
            let ret = Matft.complex.abs(a)
            
            XCTAssertEqual(ret, MfArray([[[ 0.0        ,  1.41421356,  2.82842712,  4.24264069],
                                          [ 5.65685425,  7.07106781,  8.48528137,  9.89949494]],

                                         [[11.3137085 , 12.72792206, 14.14213562, 15.55634919],
                                          [16.97056275, 18.38477631, 19.79898987, 21.21320344]]] as [[[Float]]]))
        }
    }
}
