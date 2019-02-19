package edu.gwu.akshay.catfinder.model.petfinder

import com.squareup.moshi.Json

data class StringWrapper(@Json(name = "\$t") val t: String?)