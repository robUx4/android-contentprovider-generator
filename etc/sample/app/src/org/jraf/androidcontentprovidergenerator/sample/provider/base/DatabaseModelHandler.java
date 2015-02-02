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
import org.gawst.asyncdb.source.typed.TypedDatabaseElementHandler;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

/**
 * Abstract class to handle the read/write/query of {@link MODEL} objects with a database/content provider.
 *
 * @param <MODEL>     type of the Object read/written from/to the database.
 * @param <CURSOR>    type of {@code Cursor} read from the database.
 * @param <SELECTION> type of the {@code Selection} object used to select items.
 * @see org.jraf.androidcontentprovidergenerator.sample.provider.base.AbstractCursor
 * @see org.jraf.androidcontentprovidergenerator.sample.provider.base.AbstractSelection
 */
public abstract class DatabaseModelHandler<MODEL extends BaseModel, CURSOR extends AbstractCursor, SELECTION extends AbstractSelection<SELECTION>> implements TypedDatabaseElementHandler<MODEL, CURSOR> {
    @NonNull
    public final DatabaseSerializer<MODEL, CURSOR> serializer;

    /**
     * Constructor.
     *
     * @param serializer transforms a {@link CURSOR} to a {@link MODEL} or a {@link MODEL} into {@code ContentValues}
     */
    public DatabaseModelHandler(@NonNull DatabaseSerializer<MODEL, CURSOR> serializer) {
        this.serializer = serializer;
    }

    @NonNull
    @Override
    public MODEL cursorToItem(@NonNull CURSOR cursor) throws InvalidDbEntry {
        return serializer.getValueFromCursor(cursor);
    }

    /**
     * Generate a {@link org.jraf.androidcontentprovidergenerator.sample.provider.base.AbstractSelection} object for the specified item.
     */
    protected abstract SELECTION getItemSelection(@NonNull MODEL itemToSelect);

    @NonNull
    @Override
    public String getItemSelectClause(@Nullable MODEL itemToSelect) {
        if (itemToSelect != null) {
            return getItemSelection(itemToSelect).sel();
        }
        return "";
    }

    @NonNull
    @Override
    public String[] getItemSelectArgs(@NonNull MODEL itemToSelect) {
        return getItemSelection(itemToSelect).args();
    }
}
