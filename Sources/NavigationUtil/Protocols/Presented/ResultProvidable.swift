public protocol ResultProvidable: Presentable {
    associatedtype ResultValue

    func waitResult () async throws -> ResultValue
}
