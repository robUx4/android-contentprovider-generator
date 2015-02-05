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
import org.gawst.asyncdb.source.typed.TypedMapDatabaseElementHandler;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

/**
 * Abstract class to handle the read/write/query of {@link KEY}/{@link VALUE} objects with a database/content provider.
 *
 * @param <KEY>       type of the Key read/written from/to the database.
 * @param <VALUE>     type of the Value read/written from/to the database.
 * @param <CURSOR>    type of {@code Cursor} read from the database.
 * @param <SELECTION> type of the {@code Selection} object used to select items.
 * @see AbstractCursor
 * @see AbstractSelection
 */
public abstract class MapDatabaseModelHandler<KEY, VALUE, CURSOR extends AbstractCursor, SELECTION extends AbstractSelection<SELECTION>> implements TypedMapDatabaseElementHandler<KEY, VALUE, CURSOR> {
    @NonNull
    public final MapDatabaseSerializer<KEY, VALUE, CURSOR> serializer;

    /**
     * Constructor.
     *
     * @param serializer transforms a {@link CURSOR} to a {@link KEY}/{@link VALUE} or a {@link KEY}/{@link VALUE} into {@code ContentValues}
     */
    public MapDatabaseModelHandler(@NonNull MapDatabaseSerializer<KEY, VALUE, CURSOR> serializer) {
        this.serializer = serializer;
    }

    @NonNull
    @Override
    public KEY cursorToKey(@NonNull CURSOR cursor) throws InvalidDbEntry {
        return serializer.getKeyFromCursor(cursor);
    }

    @NonNull
    @Override
    public VALUE cursorToValue(@NonNull CURSOR cursor) {
        return serializer.getValueFromCursor(cursor);
    }

    /**
     * Generate a {@link AbstractSelection} object for the specified item.
     */
    protected abstract SELECTION getItemSelection(@NonNull KEY key);

    @NonNull
    @Override
    public String getKeySelectClause(@Nullable KEY key) {
        if (key != null) {
            return getItemSelection(key).sel();
        }
        return "";
    }

    @NonNull
    @Override
    public String[] getKeySelectArgs(@NonNull KEY key) {
        return getItemSelection(key).args();
    }
}
