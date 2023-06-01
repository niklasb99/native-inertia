import Foundation
import Dispatch
import SwiftyJSON

struct SSEEvent: Encodable {
    let degree: Double
    
    init(degree: Double) {
        self.degree = degree
    }
}

func startSSEConnection() {
    
    print("startSSEConnection()")
    let manager: CompassHeading = CompassHeading()

    func handleSSEConnection(socket: URLSessionWebSocketTask) {
        
        print("handleSSEConnection()")

        let pingPayload = URLSessionWebSocketTask.Message.string(":")
        let pingInterval: TimeInterval = 5
        
        if socket.state == .running {
            print("State: running")
        } else {
            print("State: not running")
        }
        
        let timer = Timer.scheduledTimer(withTimeInterval: pingInterval, repeats: true) { _ in
            let degrees = manager.degrees
            
            print("timer")
            print(degrees)

            let event = SSEEvent(degree: degrees)
            
            let json = JSON(event) // Convert SSEEvent object to SwiftyJSON JSON object

            let jsonString = json.rawString() ?? ""
            let message = URLSessionWebSocketTask.Message.string(jsonString)
            socket.send(message) { error in
                if let error = error {
                    print("Error sending SSE event: \(error)")
                }
                print("socket send")
            }
        }
        
        // Füge den Timer zum aktuellen Runloop hinzu, damit er ordnungsgemäß funktioniert
        RunLoop.current.add(timer, forMode: .common)
        
        // Receive SSE messages
        socket.receive { result in
            // Handle SSE message receiving logic
        }
    }
    
    // Create SSE connection
    let session = URLSession(configuration: .default)
    let url = URL(string: "")!
    let socket = session.webSocketTask(with: url)
    socket.resume()
    
    // Handle SSE connection
    handleSSEConnection(socket: socket)
}
