 //
//  OffsetKey.swift
//  ManagmentApp
//
//  Created by Montserrat Gomez on 2024-06-21.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
	static var defaultValue: CGFloat = 0
	static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
		value = nextValue()
	}
}
