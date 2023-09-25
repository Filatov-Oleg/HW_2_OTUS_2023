//
//  NavigationStack.swift
//  HW_2_OTUS_2023
//
//  Created by Филатов Олег Олегович on 20.09.2023.
//

import SwiftUI

public extension AnyTransition {
    
    static var moveAndFade: AnyTransition {
        let insertion = AnyTransition.push(from: .trailing).combined(with: .opacity)
        let removal = AnyTransition.push(from: .leading).combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}

final public class NavigationStackViewModel: ObservableObject {
    
    var easing: Animation = .easeInOut(duration: 0.5)
    
    @Published fileprivate var current: Screen?
    private var screenStack: ScreenStack = .init() {
        didSet {
            current = screenStack.top()
        }
    }
    
    // MARK: - API
    
    func push<S: View>(_ screen: S) {
        withAnimation(easing) {
            let screen: Screen = .init(id: UUID().uuidString,
                                       nextScreen: AnyView(screen))
            screenStack.push(screen)
        }

    }
    
    func pop(to: PopDestination) {
        withAnimation(easing) {
            switch to {
            case .previous:
                screenStack.popToPrevious()
            case .root:
                screenStack.popToRoot()
            }
        }
    }
    
}

public struct NavigationStack<Content>: View where Content: View {

    @StateObject var viewModel: NavigationStackViewModel = .init()
    
    private let content: Content
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        let isRoot  = viewModel.current == nil
        return ZStack {
            Spacer()
            switch isRoot {
            case (true):
                content
                    .environmentObject(viewModel)
                    .transition(.moveAndFade)
                
                
            default:
                viewModel.current?.nextScreen
                    .environmentObject(viewModel)
                    .transition(.moveAndFade)
                
            }
        }
    }
}

public struct NavigationPushButton<Content, Destination>: View where Content: View, Destination: View {
    
    @EnvironmentObject var viewModel: NavigationStackViewModel
    
    private let content: Content
    private let destination: Destination
    
    public init(destination: Destination,
                @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        self.destination = destination
    }
    
    public var body: some View {
        content.onTapGesture {
            viewModel.push(destination)
        }
    }
}

public struct NavigationPopButton<Content>: View where Content: View {

    @EnvironmentObject var viewModel: NavigationStackViewModel
    
    private let content: Content
    private let destination: PopDestination
    
    public init(destination: PopDestination,
                @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        self.destination = destination
    }
    
    public var body: some View {
        content.onTapGesture {
            viewModel.pop(to: destination)
        }
    }
}

// MARK: - Enums

public enum PopDestination {
    case previous, root
        
}

// MARK: - Logic

private struct Screen: Identifiable, Equatable {

    let id: String
    let nextScreen: AnyView
    
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        lhs.id == rhs.id
    }
    
    
}

private struct ScreenStack {
    
    private var screens: [Screen] = .init()
    
    func top() -> Screen? {
        screens.last
    }
    
    mutating func push(_ s: Screen) {
        screens.append(s)
    }
    
    mutating func popToPrevious() {
        _ = screens.popLast()
    }
    
    mutating func popToRoot() {
        screens.removeAll()
    }
}

