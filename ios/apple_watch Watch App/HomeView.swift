import SwiftUI
import QRCode


func createQRCodeDocument(urlString: String) -> QRCode.Document {
        var d = QRCode.Document(generator: QRCodeGenerator_External())
        
        d.utf8String = urlString
        
        // Eye color
        d.design.shape.eye = QRCode.EyeShape.Circle()
        d.design.style.eye = QRCode.FillStyle.Solid(CGColor.fromHex(0x27307A, alpha: 1))
        // Pupil color
        d.design.shape.pupil = QRCode.PupilShape.Circle()
        d.design.style.pupil = QRCode.FillStyle.Solid(CGColor.fromHex(0xBD3045, alpha: 1))
        // Data color
        d.design.shape.onPixels = QRCode.PixelShape.Circle(insetFraction: 0.2)
        d.design.style.onPixels = QRCode.FillStyle.Solid(CGColor.fromHex(0x273179, alpha: 1))
        
//        d.logoTemplate = QRCode.LogoTemplate(
//            image: (UIImage(named: "sj_logo")?.cgImage)!,
//            path: CGPath(rect: CGRect(x: 0.35, y: 0.35, width: 0.30, height: 0.30), transform: nil),
//            inset: 3
//        )
        
        return d
    }

func currentDateTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy h:mm a" // Example date format
        
        return formatter.string(from: Date())
    }

struct HomeView: View {
    @ObservedObject var session = WatchSessionDelegate()
    @State private var message = ""

    var body: some View {
        let doc1 = createQRCodeDocument(urlString: session.log.last ?? "Default")

        VStack{
            ZStack{
                QRCodeDocumentUIView(document: doc1).padding(12)
            }.background(.white).frame(width: 120, height: 120).cornerRadius(18)
            Spacer().frame(height: 12)
            Text(session.log.last ?? "").font(.system(size:8)).foregroundColor(.white) //Last refresh : 16 March 2024, 6:22 PM
                .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button { 
                        session.sendMessage("Give me data" + currentDateTime())
                        //session.refresh()
                    } label: {
                            Image(systemName:"arrow.clockwise")
                              .foregroundColor(Color.white)
                            
                        
                                                        
                    }
                                }
            }
            }

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
    

extension CGColor {
    static func fromHex(_ hex: UInt, alpha: Double = 0) -> CGColor {
        return UIColor(red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
                       blue: CGFloat(hex & 0x0000FF) / 255.0,
                       alpha: CGFloat(alpha)).cgColor
    }
}

extension CGImage {
    @inlinable static func named(_ name: String) -> CGImage? {
        #if os(macOS)
        NSImage(named: name)?.cgImage(forProposedRect: nil, context: nil, hints: nil)
        #else
        UIImage(named: name)?.cgImage
        #endif
    }
}
