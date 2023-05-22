//
//  UIColorExtensions.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 20/05/23.
//

import UIKit

extension UIColor {
    
    // MARK: - GRAYSCALE
    
    public class var gray100: UIColor {
        guard let storedColor = UIColor(named: "gray100") else { return .red }
        return storedColor
    }
    
    public class var gray200: UIColor {
        guard let storedColor = UIColor(named: "gray200") else { return .red }
        return storedColor
    }
    
    public class var gray300: UIColor {
        guard let storedColor = UIColor(named: "gray300") else { return .red }
        return storedColor
    }
    
    public class var gray400: UIColor {
        guard let storedColor = UIColor(named: "gray400") else { return .red }
        return storedColor
    }
    
    public class var gray500: UIColor {
        return .gray
    }
    
    // MARK: - FEEDBACK
    
    public class var red100: UIColor {
        guard let storedColor = UIColor(named: "red100") else { return .red }
        return storedColor
    }
    
    public class var red200: UIColor {
        guard let storedColor = UIColor(named: "red200") else { return .red }
        return storedColor
    }
    
    public class var green100: UIColor {
        guard let storedColor = UIColor(named: "green100") else { return .red }
        return storedColor
    }
    
    public class var green200: UIColor {
        guard let storedColor = UIColor(named: "green200") else { return .red }
        return storedColor
    }
    
    public class var purple100: UIColor {
        guard let storedColor = UIColor(named: "purple100") else { return .red }
        return storedColor
    }
    
    public class var purple200: UIColor {
        guard let storedColor = UIColor(named: "purple200") else { return .red }
        return storedColor
    }
}
