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
package org.jraf.androidcontentprovidergenerator.sample.provider.serialnumber;

import org.gawst.asyncdb.InvalidDbEntry;

import android.content.ContentValues;
import android.support.annotation.NonNull;

import org.jraf.androidcontentprovidergenerator.sample.provider.base.MapDatabaseSerializer;

/**
 * A serial number.
 * @see SerialNumberSqliteMapDataSource#SerialNumberSqliteMapDataSource(android.content.Context, org.jraf.androidcontentprovidergenerator.sample.provider.base.MapDatabaseSerializer)
 */
public final class SerialNumberMapDatabaseSerializer implements MapDatabaseSerializer<SerialNumberKey, SerialNumberValue, SerialNumberCursor> {
    public static final SerialNumberMapDatabaseSerializer INSTANCE = new SerialNumberMapDatabaseSerializer();

    @NonNull
    @Override
    public SerialNumberKey getKeyFromCursor(SerialNumberCursor cursor) throws InvalidDbEntry {
        return new SerialNumberKeyImpl.Builder(cursor).build();
    }

    @NonNull
    @Override
    public SerialNumberValue getValueFromCursor(SerialNumberCursor cursor) {
        return new SerialNumberValueImpl.Builder(cursor).build();
    }

    @NonNull
    @Override
    public ContentValues getContentValuesFromData(@NonNull SerialNumberKey key, @NonNull SerialNumberValue value, boolean update) {
        SerialNumberContentValues values = new SerialNumberContentValues(key, value, update);
        return values.values();
    }
}