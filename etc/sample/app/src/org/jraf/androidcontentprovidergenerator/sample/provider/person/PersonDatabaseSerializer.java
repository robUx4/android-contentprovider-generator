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
package org.jraf.androidcontentprovidergenerator.sample.provider.person;

import org.gawst.asyncdb.InvalidDbEntry;

import android.content.ContentValues;
import android.support.annotation.NonNull;

import org.jraf.androidcontentprovidergenerator.sample.provider.base.DatabaseSerializer;

/**
 * A human being which is part of a team.
 * @see PersonContentProviderDataSource#PersonContentProviderDataSource(android.content.Context, org.jraf.androidcontentprovidergenerator.sample.provider.base.DatabaseSerializer)
 * @see PersonContentProviderDataSource#PersonContentProviderDataSource(android.content.ContentResolver, org.jraf.androidcontentprovidergenerator.sample.provider.base.DatabaseSerializer)
 * @see PersonSqliteDataSource#PersonSqliteDataSource implements DatabaseSerializer(android.content.Context, org.jraf.androidcontentprovidergenerator.sample.provider.base.DatabaseSerializer)
 */
public final class PersonDatabaseSerializer implements DatabaseSerializer<PersonModel, PersonCursor> {
    public static final PersonDatabaseSerializer INSTANCE = new PersonDatabaseSerializer();

    @NonNull
    @Override
    public PersonModel getValueFromCursor(PersonCursor cursor) throws InvalidDbEntry {
        return new PersonImpl.Builder(cursor).build();
    }

    @NonNull
    @Override
    public ContentValues getContentValuesFromData(@NonNull PersonModel data, boolean update) {
        PersonContentValues values = new PersonContentValues(data, update);
        return values.values();
    }
}