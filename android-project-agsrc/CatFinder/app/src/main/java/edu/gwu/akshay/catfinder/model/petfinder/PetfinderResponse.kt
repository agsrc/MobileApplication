package edu.gwu.akshay.catfinder.model.petfinder

import com.squareup.moshi.Json

data class PetfinderResponse(@Json(name = "petfinder") val petfinder: Petfinder)