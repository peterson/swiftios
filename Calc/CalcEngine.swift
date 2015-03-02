//
//  CalcEngine.swift
//  Calc
//
//  Created by David Peterson on 2/03/2015.
//  Copyright (c) 2015 David Peterson. All rights reserved.
//

import Foundation

class CalcEngine {

    // in Swift you can associate data with any element of the enum
    private enum Op: Printable {
        // note: Op:Printable indicates that the Op enum implements
        // the Printable protocol. It does NOT inherit from Printable!
        case Operand(Double)
        case UnaryOperation(String, Double->Double)
        case BinaryOperation(String, (Double, Double)->Double)
        
        var description:String {
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                }
            }
        }
    }
    
    private var opStack = [Op]() // [Op]() equivalent to Array<Op>()
    
    private var knownOps = [String:Op]() // [String:Op] equivalent to Dictionary<String,Op>()
    
    // Initializer
    init() {
        knownOps["*"] = Op.BinaryOperation("*") {$1 * $0}
        knownOps["/"] = Op.BinaryOperation("/") {$1 / $0}
        knownOps["+"] = Op.BinaryOperation("+") {$1 + $0}
        knownOps["-"] = Op.BinaryOperation("-") {$1 - $0}
        knownOps["√"] = Op.UnaryOperation("√", sqrt)
    }
    
    
    // returns a result and remaining ops
    private func evaluate(ops:[Op]) -> (result: Double?, remainingOps: [Op]) {

        if !ops.isEmpty {
            
            var remainingOps = ops // take a local copy, so you can invoke mutable operations
            let op = remainingOps.removeLast() // mutates local
            
            switch op {
            case .Operand(let operand):return(operand, remainingOps)
                
            case .UnaryOperation(_, let operation): // _ is underbar .. ignores the param as it is unused here
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return(operation(operand), operandEvaluation.remainingOps)
                }
                
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return(operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
            }
        }
        return (nil, ops)
    }
    
    func evaluate() -> Double? {
        let (result, remainder) = evaluate(opStack)
        println("\(opStack) = \(result) with \(remainder) left over")
        return result
    }

    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand)) // creates enum and assocs value
        return evaluate()
    }
    
    func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
    
}