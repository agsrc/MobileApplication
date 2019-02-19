package edu.gwu.akshay.catfinder.model.petfinder
import com.squareup.moshi.Json

data class Pets(@Json(name = "pet") val pet: List<PetItem>)