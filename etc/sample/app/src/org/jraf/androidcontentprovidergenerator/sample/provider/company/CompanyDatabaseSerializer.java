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

import org.jraf.androidcontentprovidergenerator.sample.provider.base.DatabaseSerializer;

/**
 * A commercial business.
 * @see CompanyContentProviderDataSource#CompanyContentProviderDataSource(android.content.Context, org.jraf.androidcontentprovidergenerator.sample.provider.base.DatabaseSerializer)
 * @see CompanyContentProviderDataSource#CompanyContentProviderDataSource(android.content.ContentResolver, org.jraf.androidcontentprovidergenerator.sample.provider.base.DatabaseSerializer)
 * @see CompanySqliteDataSource#CompanySqliteDataSource implements DatabaseSerializer(android.content.Context, org.jraf.androidcontentprovidergenerator.sample.provider.base.DatabaseSerializer)
 */
public final class CompanyDatabaseSerializer implements DatabaseSerializer<CompanyModel, CompanyCursor> {
    public static final CompanyDatabaseSerializer INSTANCE = new CompanyDatabaseSerializer();

    @NonNull
    @Override
    public CompanyModel getValueFromCursor(CompanyCursor cursor) throws InvalidDbEntry {
        return new CompanyImpl.Builder(cursor).build();
    }

    @NonNull
    @Override
    public ContentValues getContentValuesFromData(@NonNull CompanyModel data, boolean update) {
        CompanyContentValues values = new CompanyContentValues(data, update);
        return values.values();
    }
}