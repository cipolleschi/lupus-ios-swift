//
//  AppDispatchables.swift
//  Lupus
//
//  Created by Riccardo Cipolleschi on 09/05/2020.
//

import Foundation
import Katana

typealias AppSideEffectContext = SideEffectContext<AppState, AppDependencies>
protocol AppSideEffect: SideEffect where StateType == AppState, Dependencies == AppDependencies {}
protocol AppStateUpdater: StateUpdater where StateType == AppState {}

