package edu.gwu.akshay.catfinder.activity

import android.content.pm.PackageManager.PERMISSION_GRANTED
import android.location.Geocoder
import android.location.Location
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.os.PersistableBundle
import android.preference.PreferenceManager
import android.support.v4.app.ActivityCompat
import android.support.v4.content.ContextCompat
import android.support.v4.view.MenuItemCompat
import android.support.v7.widget.GridLayoutManager
import android.support.v7.widget.SearchView
import android.support.v7.widget.SearchView.OnQueryTextListener
import android.text.InputType
import android.view.Menu
import android.view.View
import android.widget.Toast
import android.widget.Toast.LENGTH_SHORT
import android.widget.Toast.makeText
import edu.gwu.akshay.catfinder.LocationDetector
import edu.gwu.akshay.catfinder.PetSearchManager
import edu.gwu.akshay.catfinder.PetSearchManager.PetSearchCompletionListener
import edu.gwu.akshay.catfinder.R
import edu.gwu.akshay.catfinder.activity.Constants.DEFAULT_ZIP_CODE
import edu.gwu.akshay.catfinder.model.petfinder.PetItem
import kotlinx.android.synthetic.main.activity_pets.*


class PetsActivity() : AppCompatActivity(), PetSearchCompletionListener, OnQueryTextListener, LocationDetector.LocationListener {
   //finding location
    override fun locationFound(location: Location) {
       //using Geocoder to locate current coordinates
        val geocoded = Geocoder(this).getFromLocation(location.latitude, location.longitude, 1)
        if (geocoded.size > 0) {
            lastZip = Integer.parseInt(geocoded[0].postalCode)
            Toast.makeText(this, "Found location: $lastZip", LENGTH_SHORT).show()
            psm.searchPets(lastZip)
        } else {
            locationNotFound(LocationDetector.FailureReason.TIMEOUT)
        }
    }
    //using stored zipcode to show pets
    override fun locationNotFound(reason: LocationDetector.FailureReason) {
        Toast.makeText(this, "Could not find location: $reason", LENGTH_SHORT).show()
        if (reason == LocationDetector.FailureReason.NO_PERMISSION) {
            Toast.makeText(this, "Requesting permission", LENGTH_SHORT).show()
            ActivityCompat.requestPermissions(this, arrayOf(android.Manifest.permission.ACCESS_FINE_LOCATION), 42)
        } else {
            Toast.makeText(this, "Loading cats for zip : $lastZip", LENGTH_SHORT).show()
            psm.searchPets(lastZip)
        }
    }
    //checking whether location permission has been granted
    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == 42 && grantResults[0] == PERMISSION_GRANTED) {
            locationDetector.detectLocation()
        }
    }

    var lastZip = DEFAULT_ZIP_CODE
    //querying the search button in menu
    override fun onQueryTextSubmit(searchText: String?): Boolean {

        try {
            val zip = Integer.parseInt(searchText)
            if (zip in 10000..99999) {
                lastZip = zip
                psm.searchPets(lastZip)
            } else {
                Toast.makeText(this, "Zip Code must be of length 5", LENGTH_SHORT).show()
            }
        } catch (e: Exception) {
            Toast.makeText(this, "Zip Code is invalid", LENGTH_SHORT).show()
        }
        return true
    }

    override fun onQueryTextChange(searchText: String?): Boolean {
        return true
    }

    var adapter: PetAdapter? = null

    private val TAG = "PetsActivity"

    override fun petsLoaded(petItems: List<PetItem>) {

        val parcelablePetItems: ArrayList<ParcelablePetItem> = arrayListOf()
        for (pet in petItems) {
            val parcelablePetItem = ParcelablePetItem.fromPetItem(pet)
            if (parcelablePetItem != null)
                parcelablePetItems.add(parcelablePetItem)
        }
        adapter = PetAdapter(parcelablePetItems, this)
        recyclerViewPets.adapter = adapter
        progressBarContainer.visibility= View.GONE
    }

    override fun petsNotLoaded() {
        println("error loading in pets")
    }


    val psm by lazy { PetSearchManager() }

    private lateinit var locationDetector: LocationDetector

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_pets)
        //adding favorite support
        if (intent.getBooleanExtra("favorites", false)) {
            val parcelablePetItems: ArrayList<ParcelablePetItem> = arrayListOf()
            progressBarContainer.visibility= View.GONE
            val data = PreferenceManager.getDefaultSharedPreferences(applicationContext)
            val allEntries = data.all
            for (entry in allEntries.entries) {
                val petString = data.getString(entry.key, null)
                if (petString != null)
                    parcelablePetItems.add(ParcelablePetItem.fromString(petString))
            }

            adapter = PetAdapter(parcelablePetItems, this)
            recyclerViewPets.adapter = adapter
        } else {
            psm.petSearchCompletionListener = this
            var newRun = false
            if (savedInstanceState != null)
                if (savedInstanceState.containsKey("lastZip"))
                    lastZip = (savedInstanceState.getInt("lastZip", DEFAULT_ZIP_CODE))
                else {
                    newRun = true
                }
            else {
                newRun = true
            }


            if (newRun) {
                locationDetector = LocationDetector(this)
                locationDetector.locationListener = this
                locationDetector.detectLocation()
            } else
                psm.searchPets(lastZip)

        }
        recyclerViewPets.layoutManager = GridLayoutManager(this, 2)
    }
    //holding the state
    override fun onSaveInstanceState(outState: Bundle?) {
        val outState = outState
        if (outState != null) {
            outState.putInt("lastZip", lastZip)
        }
        super.onSaveInstanceState(outState)
    }
    // numeric filter to search view
    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.menu_pet, menu)
        val searchView = MenuItemCompat.getActionView(menu?.findItem(R.id.action_search)) as SearchView
        searchView.setOnQueryTextListener(this)
        searchView.inputType = InputType.TYPE_CLASS_NUMBER
        searchView.queryHint = "Enter Zip Code"
        return true

    }


}

