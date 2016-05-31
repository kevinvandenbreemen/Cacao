//
//  NSStringDrawing.swift
//  Cacao
//
//  Created by Alsey Coleman Miller on 5/30/16.
//  Copyright © 2016 PureSwift. All rights reserved.
//

import Silica

public extension String {
    
    /// UIKit compatility drawing
    func drawInRect(_ rect: Rect, withAttributes attributes: [String: Any]) {
        
        guard let context = UIGraphicsGetCurrentContext()
            else { return }
        
        // get values from attributes
        let textAttributes = TextAttributes(UIKit: attributes)
        
        self.draw(in: rect, context: context, attributes: textAttributes)
    }
    
    func boundingRectWithSize(_ size: Size, options: NSStringDrawingOptions = NSStringDrawingOptions(), attributes: [String: Any], context: NSStringDrawingContext? = nil) -> Rect {
        
        let textAttributes = TextAttributes(UIKit: attributes)
        
        var rect = Rect()
        
        let textFrame = self.contentFrame(for: Rect(size: size), attributes: textAttributes)
        
        return rect
    }
}

// MARK: - Supporting Types

public typealias NSParagraphStyle = NSMutableParagraphStyle
public typealias NSStringDrawingContext = Void

public extension TextAttributes {
    
    init(UIKit attributes: [String: Any]) {
        
        var textAttributes = TextAttributes()
        
        if let font = attributes[NSFontAttributeName] as? UIFont {
            
            textAttributes.font = font
        }
        
        if let textColor = (attributes[NSForegroundColorAttributeName] as? UIColor)?.CGColor {
            
            textAttributes.color = textColor
        }
        
        if let paragraphStyle = attributes[NSParagraphStyleAttributeName] as? NSParagraphStyle {
            
            textAttributes.paragraphStyle = paragraphStyle.toCacao()
        }
        
        self = textAttributes
    }
}

/// Encapsulates the paragraph or ruler attributes.
public final class NSMutableParagraphStyle {
    
    // MARK: - Properties
    
    /// The text alignment
    public var alignment = NSTextAlignment()
    
    // MARK: - Initialization
    
    public init() { }
    
    public static func `default`() -> NSMutableParagraphStyle {
        
        return NSMutableParagraphStyle()
    }
}

extension NSMutableParagraphStyle: CacaoConvertible {
    
    public func toCacao() -> ParagraphStyle {
        
        var paragraphStyle = ParagraphStyle()
        
        paragraphStyle.alignment = alignment.toCacao()
        
        return paragraphStyle
    }
}

public enum NSTextAlignment {
    
    case Left
    case Center
    case Right
    case Justified
    case Natural
    
    public init() { self = .Left }
}

extension NSTextAlignment: CacaoConvertible {
    
    public func toCacao() -> TextAlignment {
        
        switch self {
            
        case .Left: return .left
        case .Center: return .center
        case .Right: return .right
            
        default: return .left
        }
    }
}

/// Rendering options for a string when it is drawn.
public struct NSStringDrawingOptions: OptionSet, IntegerLiteralConvertible {
    
    public static let UsesLineFragmentOrigin = NSStringDrawingOptions(rawValue: (1 << 0))
    public static let UsesFontLeading = NSStringDrawingOptions(rawValue: (1 << 1))
    public static let UsesDeviceMetrics = NSStringDrawingOptions(rawValue: (1 << 3))
    public static let TruncatesLastVisibleLine = NSStringDrawingOptions(rawValue: (1 << 5))
    
    public var rawValue: Int
    
    public init(rawValue: Int) {
        
        self.rawValue = rawValue
    }
    
    public init(integerLiteral value: Int) {
        
        self.rawValue = value
    }
    
    public init() {
        
        self = NSStringDrawingOptions.UsesLineFragmentOrigin
    }
}

#if os(Linux)
    
    /// Expects `UIFont` value.
    public let NSFontAttributeName = "NSFontAttributeName"
    
    /// Expects `UIColor` value.
    public let NSForegroundColorAttributeName = "NSForegroundColorAttributeName"
    
    /// Expects `NSMutableParagraphStyle` value.
    public let NSParagraphStyleAttributeName = "NSParagraphStyleAttributeName"
    
#endif

#if NeverCompile
    
    /// For source code compatiblity, without Foundation.
    ///
    /// - Note: You can later specify if you want `Cacao.NSString` or `Foundation.NSString` using typealiases.
    @inline(__always)
    public func NSString(string: String) -> String {
        
        return string
    }
    
#endif
