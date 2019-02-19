package edu.gwu.akshay.catfinder.activity

import retrofit2.Call
import retrofit2.http.GET
// interfacing with the API
interface PetFact {
        @GET("fact")
        fun allAPIFacts(): Call<ResponseCatFactAPI>
    }
