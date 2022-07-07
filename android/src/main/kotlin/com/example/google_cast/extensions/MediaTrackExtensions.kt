package com.example.google_cast.extensions

import com.google.android.gms.cast.MediaTrack
import com.google.gson.JsonElement
import com.google.gson.JsonObject
import org.json.JSONObject

class GoogleCastMediaTrackBuilder {
    companion object {
        fun fromMap(map: Map<String, Any?>): MediaTrack {
            val trackId = map["trackId"] as Int
            val trackType = map["type"] as Int
            val contentId = map["trackContentId"] as String
            val contentType = map["trackContentType"] as String?
            val subType = map["subtype"] as Int?
            val name = map["name"] as String?
            val language = map["language"] as String?
            val customDataData = map["customData"] as Map<String, Any?>
            val customData = JSONObject(customDataData)
            val builder = MediaTrack.Builder(trackId.toLong(), trackType)
            builder.setContentId(contentId)
            if (contentType != null)
                builder.setContentType(contentType)
            builder.setCustomData(customData)
            if (subType != null)
                builder.setSubtype(subType)
            builder.setName(name)
            builder.setLanguage(language)
            return builder.build()
        }

        fun listFromMap(items: List<Map<String, Any?>>): List<MediaTrack> {
            val list = items.map {
                fromMap(it)
            }

            return list


        }
    }
}