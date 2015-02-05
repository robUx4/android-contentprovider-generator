/*
 * This source is part of the
 *      _____  ___   ____
 *  __ / / _ \/ _ | / __/___  _______ _
 * / // / , _/ __ |/ _/_/ _ \/ __/ _ `/
 * \___/_/|_/_/ |_/_/ (_)___/_/  \_, /
 *                              /___/
 * repository.
 *
 * Copyright (C) 2012-2015 Benoit 'BoD' Lubek (BoD@JRAF.org)
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package org.jraf.androidcontentprovidergenerator.sample.provider.base;

import org.gawst.asyncdb.InvalidDbEntry;

import android.content.ContentValues;
import android.support.annotation.NonNull;

/**
 * Interface to transform a {@link CURSOR} into a {@link KEY}/{@link VALUE} object and and {@link KEY}/{@link VALUE}
 * object into {@link android.content.ContentValues} to write in the database.
 *
 * @param <KEY>    type of the key deserialized from the database.
 * @param <VALUE>  type of value deserialized from the database.
 * @param <CURSOR> type of {@code Cursor} that will be read from the database.
 */
public interface MapDatabaseSerializer<KEY, VALUE, CURSOR extends AbstractCursor> {
    /**
     * Get the {@link android.content.ContentValues} corresponding to the {@link KEY}/{@link VALUE} object to write it in the database.
     * @param key the {@link KEY} object key to write to the database.
     * @param value the {@link VALUE} object key to write to the database.
     * @param update {@code true} if the values are for an update, not an insert, you can omit keys there.
     */
    @NonNull
    ContentValues getContentValuesFromData(@NonNull KEY key, @NonNull VALUE value, boolean update);

    /**
     * Turn a {@code Cursor} into your {@link KEY} object.
     */
    @NonNull
    KEY getKeyFromCursor(CURSOR cursor) throws InvalidDbEntry;

    /**
     * Turn a {@code Cursor} into your {@link VALUE} object.
     */
    @NonNull
    VALUE getValueFromCursor(CURSOR cursor);
}
