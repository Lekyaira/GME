//
//  Random.swift
//  GME
//
//  Created by Ryan Anderson on 1/28/20.
//  Copyright © 2020 Ryan Anderson. All rights reserved.
//

//MARK: Protocol
protocol Random {
    func getNext() -> UInt64
}

//MARK: Distribution
public class Distribution {
    public func getNext() -> UInt64 {
        fatalError("getNext() not implemented!")
    }
    
    // Uniform value between 1 and 0
    public func getUniform() -> Double {
        return Double(getNext() >> 11) * (1.0 / Double((UInt64)(1) << 53))
    }
    
    // Real value between lower and upper
    public func getDouble(lower: Double, upper: Double) -> Double {
        return getUniform() * (upper - lower) + lower
    }
    
    // Real value between lower and upper
    public func getFloat(lower: Float, upper: Float) -> Float {
        return Float(getUniform()) * (upper - lower) + lower
    }
    
    // Integer value from min to max
    public func getInt(min: Int, max: Int) -> Int {
        return Int(getDouble(lower: Double(min), upper: Double(max)))
    }
    
    // Random integer
    public func getInt() -> Int {
        return getInt(min: Int.min, max: Int.max)
    }
}

//MARK: Splitmix64
public class splitmix64: Distribution, Random {
    private var s: UInt64
    
    init(seed: UInt64){
        s = seed
    }
    override init() {
        s = UInt64.random(in: UInt64.min...UInt64.max)
    }
    
    public override func getNext() -> UInt64 {
        s &+= 0x9E3779B97F4A7C15
        var z: UInt64 = s
        z = (z ^ (z >> 30)) &* 0xBf58476d1ce4e5b9;
        z = (z ^ (z >> 27)) &* 0x94D049BB133111EB;
        return z ^ (z >> 31);
    }
}

//MARK: Xorshift1024star
public class xorshift1024star: Distribution, Random {
    private var s: [UInt64] = Array(repeating: 0, count: 16)
    private var p: Int
    
    init(seed: UInt64){
        p = 0
        let rnd = splitmix64(seed: seed)
        for i in 0..<16 {
            s[i] = rnd.getNext()
        }
    }
    override init(){
        p = 0
        let rnd = splitmix64()
        for i in 0..<16 {
            s[i] = rnd.getNext()
        }
    }
    
    public override func getNext() -> UInt64 {
        let s0 = s[p]
        p = (p&+1) & 15
        var s1 = s[p]
        s1 ^= s1 << 31 //a
        s[p] = s1 ^ s0 ^ (s1 >> 11) ^ (s0 >> 30) //b,c
        return s[p] &* 1181783497276652981
    }
}
