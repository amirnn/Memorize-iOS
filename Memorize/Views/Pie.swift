//
//  Pie.swift
//  Memorize
//
//  Created by Amir Nourinia on 27.06.23.
//

import SwiftUI

struct Pie: Shape {
    var radius: CGFloat
    var clockwise: Bool
    var startAngle: Angle
    var endAngle: Angle
    
    static private func getAngle(angle: Angle) -> Angle {
//        let modulo = fmod(angle.degrees, 360)
//        return Angle(degrees: -modulo)
        angle
    }
    
    init(radius: CGFloat, clockwise: Bool, startAngle: Angle, endAngle: Angle) {
        self.radius = radius
        self.clockwise = !clockwise
        self.startAngle = Angle(degrees: startAngle.degrees - 90)
        self.endAngle = Angle(degrees: endAngle.degrees - 90)
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let middle = CGPoint(x: rect.midX, y: rect.midY)
        let v1 = CGVector(dx: 0 , dy: -radius)
        let upperStartPoint = middle + v1
        path.move(to: middle)
        path.addLine(to: upperStartPoint)
        path.addArc(center: middle,
                    radius: radius,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: clockwise)
        path.addLine(to: middle)
        return path
    }
}

struct Pie_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            let radius = 0.8 * (min(geometry.size.width, geometry.size.height) / 2)
            Pie(radius: radius, clockwise: true, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 40)).foregroundColor(.blue).opacity(0.3)
        }
        
    }
}

extension CGPoint {
    static func +(lhs: CGPoint, rhs: CGVector) -> CGPoint {
        CGPoint(x: lhs.x + rhs.dx, y: lhs.y + rhs.dy)
    }
}
