class RemoteDataSource(private val apiService: ApiInterface) {

    suspend fun getCategory(lang: Int): Response<CategoryResponse> {
        return apiService.getCategory(lang)
    }

    suspend fun getProducts(category_id: Int, lang: Int): Response<ProductsResponse> {
        return apiService.getProducts(category_id, lang)
    }

    suspend fun orders(
        table_id: Int,
        waiter_id: Int,
        lang: Int,
        orders: OrderBody
    ): Response<OrderResponse> {
        return apiService.orders(table_id, waiter_id, lang, orders)
    }
}