//
//  Regex.swift
//  CheckoutKit
//
//  Created by Manon Henrioux on 19/08/2015.
//
//

import Foundation

/** Utility class used to abstract the use of regular expressions */

open class Regex {
    var internalExpression: NSRegularExpression?
    
    /**

    Default constructor
    
    @param pattern String containing a regular expression
    
    */
    public init(pattern: String) {
        self.internalExpression = try? NSRegularExpression(pattern: pattern, options: [])
    }
    
    /**

    Function used to test if an input matches the regular expression
    
    @param input String to be tested with the regular expression
    
    */
    open func matches(_ input: String) -> Bool {
        let matches = self.internalExpression!.matches(in: input, options: [], range:NSMakeRange(0, input.count))
        return matches.count > 0
    }
    
    /**

    Function used to replace the regular expression in an input by some other characters
    
    @param input String to be modified
    
    @param template String to replace the matching parts of the input with
    
    */
    open func replace(_ input: String, template: String) -> String {
        return self.internalExpression!.stringByReplacingMatches(in: input, options: [], range: NSMakeRange(0, input.count), withTemplate: template)
    }
}
