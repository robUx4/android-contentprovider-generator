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

import org.jraf.androidcontentprovidergenerator.sample.provider.base.DatabaseSerializer;

/**
 * A serial number.
 * @see SerialNumberContentProviderDataSource#SerialNumberContentProviderDataSource(android.content.Context, org.jraf.androidcontentprovidergenerator.sample.provider.base.DatabaseSerializer)
 * @see SerialNumberContentProviderDataSource#SerialNumberContentProviderDataSource(android.content.ContentResolver, org.jraf.androidcontentprovidergenerator.sample.provider.base.DatabaseSerializer)
 * @see SerialNumberSqliteDataSource#SerialNumberSqliteDataSource implements DatabaseSerializer(android.content.Context, org.jraf.androidcontentprovidergenerator.sample.provider.base.DatabaseSerializer)
 */
public final class SerialNumberDatabaseSerializer implements DatabaseSerializer<SerialNumberModel, SerialNumberCursor> {
    public static final SerialNumberDatabaseSerializer INSTANCE = new SerialNumberDatabaseSerializer();

    @NonNull
    @Override
    public SerialNumberModel getValueFromCursor(SerialNumberCursor cursor) throws InvalidDbEntry {
        return new SerialNumberImpl.Builder(cursor).build();
    }

    @NonNull
    @Override
    public ContentValues getContentValuesFromData(@NonNull SerialNumberModel data, boolean update) {
        SerialNumberContentValues values = new SerialNumberContentValues(data, update);
        return values.values();
    }
}