/*
 Abstract:
 The file contains the Vapor view renderer.
 */

import HTMLKit
import Vapor

/// The view renderer
public class ViewRenderer {
    
    /// The event loop the view renderer is running on
    internal var eventLoop: EventLoop
    
    /// The renderer for the view renderer
    internal var renderer: Renderer
    
    /// Creates the view renderer
    public init(eventLoop: EventLoop, localization: Localization, environment: HTMLKit.Environment, security: Security) {
        
        self.eventLoop = eventLoop
        self.renderer = Renderer(localization: localization, environment: environment, security: security)
    }
    
    /// Renders a layout and its context
    public func render(_ view: some HTMLKit.View) -> EventLoopFuture<Vapor.View> {
        
        do  {
            
            var buffer = ByteBufferAllocator().buffer(capacity: 4096)
            buffer.writeString(try renderer.render(view: view))
            
            return self.eventLoop.makeSucceededFuture(View(data: buffer))
            
        } catch(let error) {
            return self.eventLoop.makeFailedFuture(error)
        }
    }
    
    /// Renders a layout and its context
    public func render(_ view: some HTMLKit.View) async throws -> Vapor.View {
        return try await render(view).get()
    }
}

extension HTMLKit.Renderer.Errors: AbortError {
 
    @_implements(AbortError, reason)
    public var abortReason: String { self.description }
    
    public var status: HTTPResponseStatus { .internalServerError }
}

extension HTMLKit.Renderer.Errors: DebuggableError {

    @_implements(DebuggableError, reason)
    public var debuggableReason: String {  self.description }
}
