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
package org.jraf.androidcontentprovidergenerator.sample.provider.company;

import org.gawst.asyncdb.InvalidDbEntry;

import android.content.ContentValues;
import android.support.annotation.NonNull;

import org.jraf.androidcontentprovidergenerator.sample.provider.base.MapDatabaseSerializer;

/**
 * A commercial business.
 * @see CompanySqliteMapDataSource#CompanySqliteMapDataSource(android.content.Context, org.jraf.androidcontentprovidergenerator.sample.provider.base.MapDatabaseSerializer)
 */
public final class CompanyMapDatabaseSerializer implements MapDatabaseSerializer<CompanyKey, CompanyValue, CompanyCursor> {
    public static final CompanyMapDatabaseSerializer INSTANCE = new CompanyMapDatabaseSerializer();

    @NonNull
    @Override
    public CompanyKey getKeyFromCursor(CompanyCursor cursor) throws InvalidDbEntry {
        return new CompanyKeyImpl.Builder(cursor).build();
    }

    @NonNull
    @Override
    public CompanyValue getValueFromCursor(CompanyCursor cursor) {
        return new CompanyValueImpl.Builder(cursor).build();
    }

    @NonNull
    @Override
    public ContentValues getContentValuesFromData(@NonNull CompanyKey key, @NonNull CompanyValue value, boolean update) {
        CompanyContentValues values = new CompanyContentValues(key, value, update);
        return values.values();
    }
}