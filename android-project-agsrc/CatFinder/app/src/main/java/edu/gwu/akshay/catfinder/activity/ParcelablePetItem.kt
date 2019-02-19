package edu.gwu.akshay.catfinder.activity

import android.os.Parcel
import android.os.Parcelable
import edu.gwu.akshay.catfinder.model.petfinder.PetItem
import java.lang.StringBuilder

//converting string to Parcelable objects
class ParcelablePetItem(
        val name: String?,
        val photoUrl: String?,
        val email: String?,
        val zip: String?,
        val id: String?,
        val breeds: String?,
        val sex: String?,
        val description: String?
) : Parcelable {


    constructor(parcel: Parcel) : this(
            parcel.readString(),
            parcel.readString(),
            parcel.readString(),
            parcel.readString(),
            parcel.readString(),
            parcel.readString(),
            parcel.readString(),
            parcel.readString()) {
    }


    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeString(name)
        parcel.writeString(photoUrl)
        parcel.writeString(email)
        parcel.writeString(zip)
        parcel.writeString(id)
        parcel.writeString(breeds)
        parcel.writeString(sex)
        parcel.writeString(description)
    }

    override fun toString(): String = "$name-----$photoUrl-----$email-----$zip-----$id-----$breeds-----$sex-----$description"


    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<ParcelablePetItem> {
        override fun createFromParcel(parcel: Parcel): ParcelablePetItem {
            return ParcelablePetItem(parcel)
        }

        override fun newArray(size: Int): Array<ParcelablePetItem?> {
            return arrayOfNulls(size)
        }

        fun fromPetItem(petItem: PetItem?): ParcelablePetItem? {
            val petItem = petItem
            val breedBuilder = StringBuilder()

            if (petItem != null) {
                petItem.breeds.breed.forEach {
                    breedBuilder.append(it.t)
                    breedBuilder.append(", ")
                }
                var breeds = ""
                if (breedBuilder.length > 0) {
                    breeds = breedBuilder.substring(0, breedBuilder.length - 2)
                }
                val photo = petItem.media.photos?.photo
                if (photo != null)
                    return ParcelablePetItem(petItem.name.t,
                            photo[3].t,
                            petItem.contact.email.t,
                            petItem.contact.zip.t,
                            petItem.id.t,
                            breeds,
                            petItem.sex.t,
                            petItem.description?.t)
                else
                    return ParcelablePetItem(petItem.name.t,
                            null,
                            petItem.contact.email.t,
                            petItem.contact.zip.t,
                            petItem.id.t,
                            breeds,
                            petItem.sex.t,
                            petItem.description?.t
                    )
            }
            return null
        }

        fun fromString(petString: String): ParcelablePetItem {
            val petStrings = petString.split("-----")
            return ParcelablePetItem(
                    petStrings[0],
                    petStrings[1],
                    petStrings[2],
                    petStrings[3],
                    petStrings[4],
                    petStrings[5],
                    petStrings[6],
                    petStrings[7])
        }
    }
}