package edu.gwu.akshay.catfinder.model.petfinder

import com.squareup.moshi.Json

data class Photos(@Json(name = "photo") val photo: List<PhotoItem>)