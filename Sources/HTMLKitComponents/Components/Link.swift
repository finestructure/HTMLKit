/*
 Abstract:
 The file contains everything related to the link component.
 */

import HTMLKit
import Foundation

/// A component that navigates to an target.
public struct Link: View, Modifiable, Identifiable {
    
    public var id: String?
    
    /// The target for the destination
    internal let target: HTMLKit.Values.Target

    /// The url path of the target.
    internal let destination: String
    
    /// The content of the link.
    internal var content: [Content]
    
    /// The classes of the link.
    internal var classes: [String]
    
    /// The events of the link.
    internal var events: [String]?
    
    /// Creates a link.
    public init(destination: String, target: HTMLKit.Values.Target = .current, @ContentBuilder<Content> content: () -> [Content]) {
        
        self.destination = destination
        self.target = target
        self.content = content()
        self.classes = ["link"]
    }
    
    /// Creates a link.
    public init(destination: URL, target: HTMLKit.Values.Target = .current, @ContentBuilder<Content> content: () -> [Content]) {
        
        self.destination = destination.absoluteString
        self.target = target
        self.content = content()
        self.classes = ["link"]
    }
    
    /// Creates a link.
    internal init(destination: String, target: HTMLKit.Values.Target, content: [Content], classes: [String], events: [String]?, id: String?) {
        
        self.destination = destination
        self.target = target
        self.content = content
        self.classes = classes
        self.events = events
        self.id = id
    }
    
    public var body: Content {
        Anchor {
            content
        }
        .reference(destination)
        .target(target)
        .class(classes.joined(separator: " "))
        .modify(unwrap: id) {
            $0.id($1)
        }
    }
    
    public func tag(_ value: String) -> Link {
        return self.mutate(id: value)
    }
}

extension Link: TextModifier {
    
    public func font(_ style: Tokens.TextStyle) -> Link {
        return self.mutate(font: style.value)
    }
    
    public func foregroundColor(_ color: Tokens.ForegroundColor) -> Link {
        return self.mutate(foregroundcolor: color.value)
    }
    
    public func fontSize(_ size: Tokens.FontSize) -> Link {
        return self.mutate(fontsize: size.value)
    }
    
    public func fontWeight(_ weight: Tokens.FontWeight) -> Link {
        return self.mutate(fontweight: weight.value)
    }
    
    public func fontTransformation(_ transformation: Tokens.TextTransformation) -> Link {
        return self.mutate(fonttransformation: transformation.value)
    }
    
    public func fontStyle(_ style: Tokens.FontStyle) -> Link {
        return self.mutate(fontstyle: style.value)
    }
    
    public func bold() -> Link {
        return self.mutate(fontweight: Tokens.FontWeight.bold.value)
    }
    
    public func bold(_ condition: Bool) -> Link {
        
        if condition {
            return self.mutate(fontweight: Tokens.FontWeight.bold.value)
        }
        
        return self
    }
    
    public func italic() -> Link {
        return self.mutate(fontstyle: Tokens.FontStyle.italic.value)
    }
    
    public func italic(_ condition: Bool) -> Link {
    
        if condition {
            return self.mutate(fontstyle: Tokens.FontStyle.italic.value)
        }
        
        return self
    }
    
    public func underline() -> Link {
        return self.mutate(fontdecoration: Tokens.TextDecoration.underline.value)
    }
    
    public func underline(_ condition: Bool) -> Link {
        
        if condition {
            return self.mutate(fontdecoration: Tokens.TextDecoration.underline.value)
        }
        
        return self
    }
    
    public func strikethrough() -> Link {
        return self.mutate(fontdecoration: Tokens.TextDecoration.strikeThrough.value)
    }
    
    public func strikethrough(_ condition: Bool) -> Link {
        
        if condition {
            return self.mutate(fontdecoration: Tokens.TextDecoration.strikeThrough.value)
        }
        
        return self
    }
    
    public func lineSpacing(_ height: Tokens.LineHeight) -> Link {
        return self.mutate(lineheight: height.value)
    }
    
    public func lineLimit(_ limit: Tokens.LineLimit) -> Link {
        return self.mutate(linelimit: limit.value)
    }
}

extension Link: ViewModifier {
    
    public func backgroundColor(_ color: Tokens.BackgroundColor) -> Link {
        return self.mutate(backgroundcolor: color.value)
    }
    
    public func opacity(_ value: Tokens.OpacityValue) -> Link {
        return self.mutate(opacity: value.value)
    }
    
    public func zIndex(_ index: Tokens.PositionIndex) -> Link {
        return self.mutate(zindex: index.value)
    }
    
    public func hidden() -> Link {
        return self.mutate(viewstate: Tokens.ViewState.hidden.value)
    }
    
    public func hidden(_ condition: Bool) -> Link {
        
        if condition {
            return self.mutate(viewstate: Tokens.ViewState.hidden.value)
        }
        
        return self
    }
    
    public func colorScheme(_ scheme: Tokens.ColorScheme) -> Link {
        return self.mutate(scheme: scheme.value)
    }
    
    public func padding(insets: EdgeSet = .all, length: Tokens.PaddingLength = .small) -> Link {
        return self.mutate(padding: length.value, insets: insets)
    }
    
    public func borderShape(_ shape: Tokens.BorderShape) -> Link {
        return self.mutate(bordershape: shape.value)
    }
    
    public func borderColor(_ color: Tokens.BorderColor) -> Link {
        return self.mutate(bordercolor: color.value)
    }
    
    public func frame(width: Tokens.ColumnSize, offset: Tokens.ColumnOffset? = nil) -> Link {
        return mutate(frame: width.value, offset: offset?.value)
    }
    
    public func margin(insets: EdgeSet = .all, length: Tokens.MarginLength = .small) -> Link {
        return self.mutate(margin: length.value, insets: insets)
    }
}
