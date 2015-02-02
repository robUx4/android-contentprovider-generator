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

import android.content.ContentResolver;
import android.content.Context;
import android.database.Cursor;
import android.support.annotation.NonNull;

import org.jraf.androidcontentprovidergenerator.sample.provider.base.AbstractContentProviderDataSource;
import org.jraf.androidcontentprovidergenerator.sample.provider.base.DatabaseModelHandler;
import org.jraf.androidcontentprovidergenerator.sample.provider.base.DatabaseSerializer;

/**
 * A human being which is part of a team.
 * <p>A data source to be used with {@link org.gawst.asyncdb.AsynchronousDbHelper AsynchronousDbHelper}.</p>
 * @see PersonDatabaseSerializer
 */
public class PersonContentProviderDataSource extends AbstractContentProviderDataSource<PersonModel, PersonCursor, PersonSelection> {
    /**
     * Contructor.
     * <p>Uses a {@link org.jraf.androidcontentprovidergenerator.sample.provider.person.PersonDatabaseModelHandler} to read/write data in the Content Provider.</p>
     *
     * @param contentResolver ContentResolver used to access the {@link android.content.ContentProvider ContentProvider}
     */
    public PersonContentProviderDataSource(@NonNull ContentResolver contentResolver) {
        this(contentResolver, PersonDatabaseSerializer.INSTANCE);
    }

    /**
     * Contructor.
     * <p>Uses a {@link org.jraf.androidcontentprovidergenerator.sample.provider.person.PersonDatabaseModelHandler} to read/write data in the Content Provider.</p>
     *
     * @param context    Context used to get the {@link android.content.ContentResolver ContentResolver} used to access the {@link android.content.ContentProvider ContentProvider}
     */
    public PersonContentProviderDataSource(@NonNull Context context) {
        this(context, PersonDatabaseSerializer.INSTANCE);
    }

    /**
     * Contructor.
     * <p>Uses a {@link org.jraf.androidcontentprovidergenerator.sample.provider.person.PersonDatabaseModelHandler} to read/write data in the Content Provider.</p>
     *
     * @param contentResolver ContentResolver used to access the {@link android.content.ContentProvider ContentProvider}
     * @param serializer      the serializer that will transform a {@link PersonCursor} to a {@link PersonModel}
     *                        or a {@link PersonModel} into {@code ContentValues}
     */
    public PersonContentProviderDataSource(@NonNull ContentResolver contentResolver, @NonNull DatabaseSerializer<PersonModel, PersonCursor> serializer) {
        this(contentResolver, new PersonDatabaseModelHandler(serializer));
    }

    /**
     * Contructor.
     * <p>Uses a {@link org.jraf.androidcontentprovidergenerator.sample.provider.person.PersonDatabaseModelHandler} to read/write data in the Content Provider.</p>
     *
     * @param context    Context used to get the {@link android.content.ContentResolver ContentResolver} used to access the {@link android.content.ContentProvider ContentProvider}
     * @param serializer the serializer that will transform a {@link PersonCursor} to a {@link PersonModel}
     *                   or a {@link PersonModel} into {@code ContentValues}
     */
    public PersonContentProviderDataSource(@NonNull Context context, @NonNull DatabaseSerializer<PersonModel, PersonCursor> serializer) {
        this(context, new PersonDatabaseModelHandler(serializer));
    }

    /**
     * Contructor.
     *
     * @param contentResolver ContentResolver used to access the {@link android.content.ContentProvider ContentProvider}.
     * @param modelHandler to handle {@link PersonModel} read/write/query in the Content Provider.
     */
    public PersonContentProviderDataSource(@NonNull ContentResolver contentResolver, @NonNull DatabaseModelHandler<PersonModel, PersonCursor, PersonSelection> modelHandler) {
        super(contentResolver, PersonColumns.CONTENT_URI, modelHandler);
    }

    /**
     * Contructor.
     *
     * @param context      Context used to get the {@link android.content.ContentResolver ContentResolver} used to access the {@link android.content.ContentProvider ContentProvider}
     * @param modelHandler to handle {@link PersonModel} read/write/query in the Content Provider.
     */
    public PersonContentProviderDataSource(@NonNull Context context, @NonNull DatabaseModelHandler<PersonModel, PersonCursor, PersonSelection> modelHandler) {
        super(context, PersonColumns.CONTENT_URI, modelHandler);
    }

    @Override
    public PersonCursor wrapCursor(Cursor cursor) {
        return new PersonCursor(cursor);
    }
}