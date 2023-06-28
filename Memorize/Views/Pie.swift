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
    
    static private func getAngle(angle: Angle, clockwise: Bool) -> Angle {
        return clockwise ? angle: Angle(degrees: -1 * angle.degrees)
    }
    
    init(radius: CGFloat, clockwise: Bool, startAngle: Angle, endAngle: Angle) {
        self.radius = radius
        self.clockwise = !clockwise
        self.startAngle = startAngle
        self.endAngle = endAngle
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let middle = CGPoint(x: rect.midX, y: rect.midY)
        let v1 = CGVector(dx: 0 , dy: -radius)
        let upperStartPoint = middle + v1
        path.move(to: middle)
        path.addLine(to: upperStartPoint)
        path.addArc(center: middle, radius: radius, startAngle: Pie.getAngle(angle: startAngle, clockwise: clockwise) , endAngle: Pie.getAngle(angle: endAngle, clockwise: clockwise), clockwise: clockwise)
        return path
    }
}

struct Pie_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            let radius = min(geometry.size.width, geometry.size.height) / 2
            Pie(radius: radius, clockwise: true, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 0))
        }
        
    }
}

extension CGPoint {
    static func +(rhs: CGPoint, lhs: CGVector) -> CGPoint {
        CGPoint(x: rhs.x + lhs.dx, y: rhs.y + lhs.dy)
    }
}
