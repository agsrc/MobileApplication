package edu.gwu.akshay.catfinder.model.petfinder

import com.squareup.moshi.Json

data class Contact(
        @Json(name = "email") val email: StringWrapper,
        @Json(name = "zip") val zip: StringWrapper
)
