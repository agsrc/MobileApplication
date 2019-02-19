package edu.gwu.akshay.catfinder.model.petfinder

import com.squareup.moshi.Json

data class Petfinder(@Json(name = "pets") val pets: Pets?)