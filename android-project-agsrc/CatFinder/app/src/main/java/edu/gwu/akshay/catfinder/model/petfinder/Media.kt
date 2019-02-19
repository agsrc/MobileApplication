package edu.gwu.akshay.catfinder.model.petfinder
import com.squareup.moshi.Json

data class Media(@Json(name = "photos") val photos: Photos?)