class Repository(
    localDataSource: LocalDataSource,
    remoteDataSource: RemoD,
) {
    val remote = remoteDataSource
    val local = localDataSource
}