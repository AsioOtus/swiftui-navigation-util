public protocol NavigationInterceptable <Interceptor> {
    associatedtype Requirement: NavigationRequirement
    associatedtype Interceptor: NavigationInterceptor where Interceptor.Requirement == Requirement

    var navigationInterceptor: Interceptor { get }
}
