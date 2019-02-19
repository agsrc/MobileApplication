package edu.gwu.akshay.catfinder.activity

import android.app.Activity
import android.support.v7.widget.RecyclerView
import android.view.LayoutInflater
import android.view.ViewGroup
import edu.gwu.akshay.catfinder.R
import edu.gwu.akshay.catfinder.model.petfinder.PetItem

class PetAdapter(val petItems: List<ParcelablePetItem>, val activity: Activity) : RecyclerView.Adapter<PetViewHolder>() {
    override fun onCreateViewHolder(parent: ViewGroup, position: Int): PetViewHolder =
            PetViewHolder(LayoutInflater.from(parent.context).inflate(R.layout.recycler_view_item, parent,
                    false), activity = activity, adapter = this)

    override fun getItemCount(): Int = petItems.size

    override fun onBindViewHolder(viewHolder: PetViewHolder, position: Int) {
        viewHolder.bind(petItems[position])
    }

}

