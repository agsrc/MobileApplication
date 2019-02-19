package edu.gwu.akshay.catfinder.activity

import android.app.Activity
import android.app.ActivityOptions
import android.content.Intent
import android.graphics.Color
import android.preference.PreferenceManager
import android.support.v4.content.ContextCompat
import android.support.v7.widget.RecyclerView
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import com.squareup.picasso.Picasso
import edu.gwu.akshay.catfinder.R
import org.jetbrains.anko.textColor

class PetViewHolder(itemView: View, var pet: ParcelablePetItem? = null, val activity: Activity, val adapter: PetAdapter) :
        RecyclerView.ViewHolder(itemView), View.OnClickListener {

    override fun onClick(v: View?) {
        if (v == itemView) {
            this.imageView.transitionName = "petImage"
            activity.startActivity(Intent(activity, PetDetailsActivity::class.java)
                    .putExtra("pet", this.pet?.let { it }), ActivityOptions.makeSceneTransitionAnimation(activity, imageView, "petImage").toBundle())
        }
        // saving into shared prefernce when fav button is called
        else if (v == favoriteButton) {
            val pet = this.pet
            val data = PreferenceManager.getDefaultSharedPreferences(activity.applicationContext)
            if (pet != null) if (data.contains(pet.id)) data.edit().remove(pet.id).apply() else data.edit().putString(pet.id, pet.toString()).apply()
            adapter.notifyDataSetChanged()


        }
    }
        // setting values
    val textViewName: TextView = itemView.findViewById(R.id.textViewPetName)
    val textViewSex: TextView = itemView.findViewById(R.id.textViewPetSex)
    val imageView: ImageView = itemView.findViewById(R.id.imageViewThumbnail)
    val favoriteButton: ImageView = itemView.findViewById(R.id.imageViewFavoriteButton)

    init {
        itemView.setOnClickListener(this)
        favoriteButton.setOnClickListener(this)
    }
        // setting colors for gender
    fun bind(pet: ParcelablePetItem) {
        this.pet = pet
        textViewName.text = pet.name
        textViewSex.text=pet.sex
        if(pet.sex=="M"){
            textViewSex.textColor=Color.BLUE
        }
        else{
            textViewSex.textColor=Color.MAGENTA
        }
        //loading picture into image view
        Picasso.get().load(pet.photoUrl).into(imageView);
        val data = PreferenceManager.getDefaultSharedPreferences(activity.applicationContext)
        if (data.contains(pet.id)) {
            val starOn = ContextCompat.getDrawable(activity.applicationContext, android.R.drawable.btn_star_big_on)
            favoriteButton.setImageDrawable(starOn)
        } else {
            val starOff = ContextCompat.getDrawable(activity.applicationContext, android.R.drawable.btn_star_big_off)
            favoriteButton.setImageDrawable(starOff)
        }

    }

    private val TAG = "PetAdapter"
}