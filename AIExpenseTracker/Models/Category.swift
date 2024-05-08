//
//  Category.swift
//  AIExpenseTracker
//
//  Created by Alfian Losari on 09/05/24.
//

import Foundation
import SwiftUI

enum Category: String, Identifiable, CaseIterable {
    
    var id: Self { self }
    
    case accountingAndLegalFees = "Accounting and legal fees"
    case bankFees = "Bank fees"
    case consultantsAndProfessionalServices = "Consultants and professional services"
    case depreciation = "Depreciation"
    case employeeBenefits = "Employee benefits"
    case employeeExpenses = "Employee expenses"
    case entertainment = "Entertainment"
    case food = "Food"
    case gifts = "Gifts"
    case health = "Health"
    case insurance = "Insurance"
    case interest = "Interest"
    case learning = "Learning"
    case licensingFees = "Licensing fees"
    case marketing = "Marketing"
    case membershipFees = "Membership fees"
    case officeSupplies = "Office supplies"
    case payroll = "Payroll"
    case repairs = "Repairs"
    case rent = "Rent"
    case rentOrMortgagePayments = "Rent or mortgage payments"
    case software = "Software"
    case tax = "Tax"
    case travel = "Travel"
    case utilities = "Utilities"
    
    var systemNameIcon: String {
        switch self {
        case .insurance: return "shield"
        case .utilities: return "drop"
        case .marketing: return "megaphone"
        case .bankFees: return "creditcard"
        case .officeSupplies: return "folder"
        case .payroll: return "dollarsign.circle"
        case .employeeBenefits: return "person.2.square.stack"
        case .employeeExpenses: return "briefcase"
        case .food: return "bag.circle"
        case .licensingFees: return "cart"
        case .repairs: return "wrench"
        case .travel: return "airplane"
        case .accountingAndLegalFees: return "scalemass"
        case .gifts: return "gift"
        case .rent: return "house"
        case .learning: return "book"
        case .entertainment: return "film"
        case .interest: return "percent"
        case .health: return "heart"
        case .membershipFees: return "person.2"
        case .consultantsAndProfessionalServices: return "briefcase.fill"
        case .depreciation: return "arrow.down.doc"
        case .rentOrMortgagePayments: return "house.fill"
        case .software: return "app"
        case .tax: return "scalemass.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .insurance: return Color(red: 0.086, green: 0.525, blue: 0.820)
        case .utilities: return Color(red: 0.369, green: 0.769, blue: 0.439)
        case .marketing: return Color(red: 0.843, green: 0.000, blue: 0.239)
        case .bankFees: return Color(red: 0.976, green: 0.463, blue: 0.031)
        case .officeSupplies: return Color(red: 1.000, green: 0.745, blue: 0.161)
        case .payroll: return Color(red: 0.561, green: 0.318, blue: 0.784)
        case .employeeBenefits: return Color(red: 1.000, green: 0.565, blue: 0.667)
        case .employeeExpenses: return Color.cyan
        case .food: return Color(red: 0.553, green: 0.251, blue: 0.663)
        case .licensingFees: return Color(red: 0.420, green: 0.749, blue: 0.604)
        case .repairs: return Color(red: 0.545, green: 0.000, blue: 0.000)
        case .travel: return Color(red: 0.078, green: 0.482, blue: 0.894)
        case .accountingAndLegalFees: return Color.pink
        case .gifts: return Color(red: 1.000, green: 0.498, blue: 0.000)
        case .rent: return Color(red: 0.196, green: 0.714, blue: 0.875)
        case .learning: return Color(red: 0.239, green: 0.467, blue: 0.855)
        case .entertainment: return Color(red: 0.667, green: 0.180, blue: 0.686)
        case .interest: return Color(red: 0.949, green: 0.361, blue: 0.000)
        case .health: return Color(red: 0.835, green: 0.000, blue: 0.000)
        case .membershipFees: return Color(red: 0.259, green: 0.675, blue: 0.820)
        case .consultantsAndProfessionalServices: return Color(red: 0.263, green: 0.569, blue: 0.275)
        case .depreciation: return Color.mint
        case .rentOrMortgagePayments: return Color(red: 0.114, green: 0.647, blue: 0.871)
        case .software: return Color(red: 0.184, green: 0.463, blue: 0.239)
        case .tax: return Color.red
        }
    }

}
