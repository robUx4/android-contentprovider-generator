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
 * Interface to transform a {@link CURSOR} into a {@link MODEL} object and and {@link MODEL} object into {@link android.content.ContentValues}
 * to write in the database.
 * @param <MODEL> type of object deserialized from the database.
 * @param <CURSOR> type of {@code Cursor} that will be read from the database.
 */
public interface DatabaseSerializer<MODEL extends BaseModel, CURSOR extends AbstractCursor> {
    /**
     * Get the {@link android.content.ContentValues} corresponding to the {@link MODEL} object to write it in the database.
     * @param data the {@link MODEL} object to write to the database.
     * @param update {@code true} if the values are for an update, not an insert, you can omit keys there.
     */
    @NonNull
    ContentValues getContentValuesFromData(@NonNull MODEL data, boolean update);

    /**
     * Turn a {@code Cursor} into your {@link MODEL} object.
     */
    @NonNull
    MODEL getValueFromCursor(CURSOR cursor) throws InvalidDbEntry;
}
