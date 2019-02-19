package edu.gwu.akshay.catfinder.activity

import com.squareup.moshi.Json

 class ResponseCatFactAPI {
    @Json(name="fact")
    val fact: String? = null

    @Json(name="length")
    val length: Int? = null
}
