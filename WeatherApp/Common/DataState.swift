enum DataState<T> {
    case hasData(_ data: T)
    case loading
    case error(_ data: T)
}
