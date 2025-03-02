//
//  CustomerDetails.swift
//  CheckoutKit
//
//  Created by Manon Henrioux on 17/08/2015.
//  Copyright (c) 2015 Checkout.com. All rights reserved.
//

import Foundation

/** Class used to represent customer's details */

@objc open class CustomerDetails:NSObject {
    @objc var address1: String?
    @objc var address2: String?
    @objc var postCode: String?
    @objc var country: String?
    @objc var city: String?
    @objc var state: String?
    @objc var phone: Phone?
    
    /**
    
    Default constructor
    
    @param address1 String containing the first line of the customer's address
    
    @param address2 String containing the second line of the customer's address
    
    @param postCode String containing the postal code of the customer's address
    
    @param country String containing the country of the customer's address
    
    @param city String containing the city of the customer's address
    
    @param state String containing the state of the customer's address
    
    @param phoneCountryCode String containing the country code of the customer
    
    @param phoneNumber String containing the phone number of the customer
    
    */
    
    public init(address1: String, address2: String, postCode: String, country: String, city: String, state: String, phoneNumber: String, phoneCountryCode: String) {
        self.address1 = address1
        self.address2 = address2
        self.city = city
        self.country = country
        self.phone = Phone(countryCode: phoneCountryCode, number: phoneNumber)
        self.postCode = postCode
        self.state = state
    }
    
    /**
    
    Convenience constructor
    
    @param data: Dictionary [String: AnyObject] containing a JSON representation of a CustomerDetails instance
    
    */
    
    public required init(data: [String: AnyObject]) {
        self.address1 = data["addressLine1"] as? String
        self.address2 = data["addressLine2"] as? String
        self.postCode = data["postcode"] as? String
        self.country = data["country"] as? String
        self.city = data["city"] as? String
        self.state = data["state"] as? String
        if let phoneData = data["phone"] as? [String: AnyObject] {
            self.phone = Phone(data: phoneData)
        }
    }
    
    /**
    
    Function returning the JSON representation of this CustomerDetails instance
    
    @return Dictionary [String: AnyObject] containing the JSON components of the instance
    
    */
    
    func getJson() -> [String: AnyObject] {
        var dic: [String: AnyObject] = [:]
        if !(phone == nil) {
            dic["phone"] = phone?.getJson()! as AnyObject?
        }
        if !(address1 == nil) {
            dic["addressLine1"] = address1! as AnyObject?
        }
        if !(address2 == nil) {
            dic["addressLine2"] = address2! as AnyObject?
        }
        if !(postCode == nil) {
            dic["postcode"] = postCode! as AnyObject?
        }
        if !(country == nil) {
            dic["country"] = country! as AnyObject?
        }
        if !(city == nil) {
            dic["city"] = city! as AnyObject?
        }
        if !(state == nil) {
            dic["state"] = state! as AnyObject?
        }
        return dic
    }
}

/// Class used to represent one's phone information

@objc class Phone: NSObject, Serializable {
    @objc var countryCode: String?
    @objc var number: String?
    
    init(countryCode: String, number: String) {
        self.number = number
        self.countryCode = countryCode
    }
    
    /**
    
    Convenience constructor
    
    @param data: Dictionary [String: AnyObject] containing a JSON representation of a Phone instance
    
    */

    required init?(data: [String: AnyObject]) {
        self.countryCode = data["countrycode"] as? String
        self.number = data["number"] as? String
//        if self.countryCode == nil || self.number == nil {
//            return nil
//        }
    }
    
    /**
    
    Function returning the JSON representation of this Phone instance
    
    @return Dictionary [String: AnyObject] containing the JSON components of the instance
    
    */
    
    func getJson() -> [String: AnyObject]? {
        if self.countryCode == nil || self.number == nil {
            return nil
        }
        let dic: [String: AnyObject] = [
            "number": number! as AnyObject,
            "countrycode": countryCode! as AnyObject
        ]
        return dic
    }
}
