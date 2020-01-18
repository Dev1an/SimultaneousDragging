//
//  ContentView.swift
//  SimultaneousDragging
//
//  Created by Damiaan on 18/01/2020.
//  Copyright © 2020 Devian. All rights reserved.
//

import SwiftUI

struct FingerInfo {
	let reference: CGPoint
	let location: CGPoint
}

struct ContentView: View {
	@State var panFinger: FingerInfo?
	@State var zoomFinger: FingerInfo?

    var body: some View {
		let pan = DragGesture(minimumDistance: 0, coordinateSpace: .named("fingers"))
			.onChanged(change(finger: \.$panFinger))
			.onEnded(remove(finger: \.$panFinger))
		let zoom = DragGesture(minimumDistance: 0, coordinateSpace: .named("fingers"))
			.onChanged(change(finger: \.$zoomFinger))
			.onEnded(remove(finger: \.$zoomFinger))

		return FingerOverlays(panFinger: panFinger, zoomFinger: zoomFinger)
			.frame(
				maxWidth: .infinity,
				maxHeight: .infinity,
				alignment: .topLeading
			)
			.background(Color.black)
			.gesture(pan.simultaneously(with: zoom))
    }

	typealias FingerPath = KeyPath<ContentView, Binding<FingerInfo?>>
	func change(finger: FingerPath) -> (DragGesture.Value) -> Void {
		{ self[keyPath: finger].wrappedValue = FingerInfo(reference: $0.startLocation, location: $0.location) }
	}
	func remove(finger: FingerPath) -> (DragGesture.Value) -> Void {
		{_ in self[keyPath: finger].wrappedValue = nil }
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
