package edu.gwu.akshay.catfinder.model.petfinder

import com.squareup.moshi.Json

data class Breeds(@Json(name = "breed") val breed: List<StringWrapper>)