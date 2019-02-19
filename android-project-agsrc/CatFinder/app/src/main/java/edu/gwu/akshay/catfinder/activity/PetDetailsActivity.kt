package edu.gwu.akshay.catfinder.activity

import android.content.Intent
import android.net.Uri
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import com.squareup.picasso.Picasso
import edu.gwu.akshay.catfinder.R
import edu.gwu.akshay.catfinder.model.petfinder.Pets
import kotlinx.android.synthetic.main.activity_pet_details.*

class PetDetailsActivity : AppCompatActivity() {


    lateinit var pet: ParcelablePetItem

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_pet_details)
        //storing parcelable pet object
        pet = intent.getParcelableExtra<ParcelablePetItem>("pet")

        //loading photo into the imageView(imageViewBigPhoto)
        Picasso.get().load(pet.photoUrl).into(imageViewBigPhoto)

        //setting values
        textViewDescription.text = pet.description
        name_textView.text=pet.name
        gender_textView.text=pet.sex
        breed_textView.text=pet.breeds
        zip_textView.text=pet.zip



    }
    //inflate menu_pet_details here
    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.menu_pet_details, menu)
        return true
    }
    // forwarding support
    override fun onOptionsItemSelected(item : MenuItem?) :Boolean{
        // email clicked
        if(item?.itemId == R.id.mail){
            val intent = Intent(Intent.ACTION_SENDTO)
            intent.data = Uri.parse("mailto:${pet.email}")
            intent.putExtra(Intent.EXTRA_EMAIL, pet.email);
            intent.putExtra(Intent.EXTRA_SUBJECT, "Subject");
            intent.putExtra(Intent.EXTRA_TEXT, "Body");
            if(intent.resolveActivity(this.packageManager) != null){
                startActivity(intent)
            }
            //share clicked
        } else if(item?.itemId == R.id.share)
            {
            val sharingIntent = Intent(android.content.Intent.ACTION_SEND)
            sharingIntent.type = "text/plain"
            val shareBody = "Check this out."
            sharingIntent.putExtra(android.content.Intent.EXTRA_SUBJECT, "Subject Here")
            sharingIntent.putExtra(android.content.Intent.EXTRA_TEXT, shareBody)
            startActivity(Intent.createChooser(sharingIntent, "Share via"))

        }
        return super.onOptionsItemSelected(item)
    }

}

