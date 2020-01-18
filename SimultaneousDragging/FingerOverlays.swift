//
//  FingersOverlay.swift
//  SimultaneousDragging
//
//  Created by Damiaan on 18/01/2020.
//  Copyright © 2020 Devian. All rights reserved.
//

import SwiftUI

fileprivate let panFingerColor = Color.red.opacity(0.2)
fileprivate let zoomFingerColor = Color.accentColor.opacity(0.2)

struct FingerOverlays: View {
	let panFinger: FingerInfo?
	let zoomFinger: FingerInfo?

	var body: some View {
		ZStack(alignment: .topLeading) {
			FingerIndicator(
				location: panFinger?.location,
				color: panFingerColor,
				isReference: false
			)
			FingerIndicator(
				location: panFinger?.reference,
				color: panFingerColor,
				isReference: true
			)
			FingerIndicator(
				location: zoomFinger?.location,
				color: zoomFingerColor,
				isReference: false
			)
			FingerIndicator(
				location: zoomFinger?.reference,
				color: zoomFingerColor,
				isReference: true
			)
		}.coordinateSpace(name: "fingers")
	}

	struct FingerIndicator: View {
		let location: CGPoint?
		let color: Color
		let isReference: Bool

		var body: some View {
			Circle()
				.foregroundColor(color)
				.frame(width: size, height: size, alignment: .center)
				.position(location ?? .zero)
				.opacity(location == nil ? 0 : 1)
		}

		var size: CGFloat { isReference ? 40 : 80 }
	}
}


struct FingerOverlays_Previews: PreviewProvider {
    static var previews: some View {
        FingerOverlays(
			panFinger: FingerInfo(
				reference: CGPoint(x: 50, y: 50),
				location: CGPoint(x: 90, y: 100)
			),
			zoomFinger: FingerInfo(
				reference: CGPoint(x: 150, y: 40),
				location: CGPoint(x: 150, y: 110)
			)
		)
    }
}
