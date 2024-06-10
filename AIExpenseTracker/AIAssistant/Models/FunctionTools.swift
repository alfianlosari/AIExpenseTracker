//
//  FunctionTools.swift
//  AIExpenseTracker
//
//  Created by Alfian Losari on 09/06/24.
//

import ChatGPTSwift
import Foundation

enum AIAssistantFunctionType: String {
    case addExpenseLog
    case listExpenses
    case visualizeExpenses
}

typealias PropKeyValue = (key: String, value: [String: Any])

let titleProp = (key: "title",
                 value: [
                    "type": "string",
                    "description": "title or description of the expense"
                 ])

let amountProp = (key: "amount",
                  value: [
                    "type": "number",
                    "description": "cost or amount of the expense"
                  ])

let currencyProp = (key: "currency",
                    value: [
                        "type": "string",
                        "description": "Currency of the amount or cost. If you're not sure, just use USD as default value, no need to confirm with user"
                    ])
                    
let dateProp = (key: "date",
                value: [
                    "type": "string",
                    "description": "date of expense. always use this format as the response yyyy-MM-dd. if no year is provided just use current year"
                ])
                
let categoryProp = (key: "category",
                    value: [
                        "type": "string",
                        "enum": Category.allCases.map { $0.rawValue },
                        "description": "The category of the expense, if it's not provided explicitly by the user, you should infer it automatically based on the title of expense."
                    ])

let startDateProp = (key: "startDate",
                     value: [
                        "type": "string",
                        "description": "start date. always use this format as the response yyyy-MM-dd. If no year is provided, just use current year"
                     ])


let endDateProp = (key: "endDate",
                   value: [
                    "type": "string",
                    "description": "end date. always use this format as the response yyyy-MM-dd. if no year is provided just use current year"
                   ])
                   
 let sortOrderProp = (key: "sortOrder",
                     value: [
                        "type": "string",
                        "enum": ["ascending", "descending"],
                        "description": "the sort order of the list. if not provided, use descending as default value"
                     ])

let quantityOfLogsProp = (key: "quantityOfLogs",
                          value: [
                            "type": "number",
                            "description": "Number of logs to be listed"
                          ])


let chartTypeProp = (key: "chartType",
                     value: [
                        "type": "string",
                        "enum": ["pie", "bar"],
                        "description": "the type of chart to be shown. if not provided, use pie as default value."
                     ])
                     

func createParameters(properties: [PropKeyValue], requiredProperties: [PropKeyValue]? = nil) -> Components.Schemas.FunctionParameters {
    var propsDict = [String: [String: Any]]()
    properties.forEach {
        propsDict[$0.key] = $0.value
    }
    return try! .init(additionalProperties: .init(unvalidatedValue: [
        "type": "object",
        "properties": propsDict,
        "required": requiredProperties?.compactMap { $0.key } ?? []
    ]))
}

func createFunction(name: String, description: String, properties: [PropKeyValue], requiredProperties: [PropKeyValue]? = nil) -> ChatCompletionTool {
    .init(_type: .function, function: .init(
        description: description,
        name: name,
        parameters: createParameters(properties: properties, requiredProperties: requiredProperties)))
}

let tools: [Components.Schemas.ChatCompletionTool] = [
    createFunction(name: AIAssistantFunctionType.addExpenseLog.rawValue,
                   description: "Add expense log",
                   properties: [titleProp,
                                amountProp,
                                currencyProp,
                                categoryProp,
                                dateProp],
                   requiredProperties: [titleProp, amountProp, categoryProp]),
    createFunction(name: AIAssistantFunctionType.listExpenses.rawValue,
                   description: "list expenses logs",
                   properties: [categoryProp,
                                dateProp,
                                startDateProp,
                                endDateProp,
                                sortOrderProp,
                                quantityOfLogsProp
                               ]),
    createFunction(name: AIAssistantFunctionType.visualizeExpenses.rawValue,
                   description: "visualize expenses logs in pie or bar chart",
                   properties: [chartTypeProp,
                                dateProp,
                                startDateProp,
                                endDateProp
                               ],
                  requiredProperties: [chartTypeProp])
]
