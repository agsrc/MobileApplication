package edu.gwu.akshay.catfinder.activity

import android.content.Intent
import android.content.SharedPreferences
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.preference.PreferenceManager
import android.util.Log
import android.view.Menu
import android.view.View
import android.widget.TextView
import edu.gwu.akshay.catfinder.LocationDetector
import edu.gwu.akshay.catfinder.R
import kotlinx.android.synthetic.main.activity_main.*
import org.jetbrains.anko.doAsync
import retrofit2.Retrofit
import retrofit2.converter.moshi.MoshiConverterFactory

class MenuActivity : AppCompatActivity() {
    lateinit var pet_cat:TextView
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        // background thread support
        doAsync {
            val retrofit = Retrofit.Builder()
                    .baseUrl("https://catfact.ninja/")
                    .addConverterFactory(MoshiConverterFactory.create())
                    .build()
            val apiEndpoint = retrofit.create(PetFact::class.java)

            val response = apiEndpoint.allAPIFacts().execute()

            if (response.isSuccessful) {
                Log.d("hii","retrofit succesfull")
                var news = response.body()
                runOnUiThread {
                    pet_cat.setText(news?.fact)
                }


            } else {
                Log.d("hii","something wrong")

            }
        }

        pet_cat=findViewById(R.id.catfact_textView)
    }
        //method for favorite cat button
    fun favoriteCat() {
        startActivity(Intent(this, PetsActivity::class.java).putExtra("favorites", true))
    }

    fun onClick(view: View) {
        if (view == buttonFindCat)
            findCat();
        else if (view == buttonFavCat)
            favoriteCat();
    }
        //switching to petsactivity
    private fun findCat() {
        startActivity(Intent(this, PetsActivity::class.java))
    }
}
