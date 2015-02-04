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
package org.jraf.androidcontentprovidergenerator.sample.provider.personteam;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

import org.gawst.asyncdb.source.typed.TypedDatabaseSource;
import org.jraf.androidcontentprovidergenerator.sample.provider.base.AbstractCursorLoader;

/**
 * Simple CursorLoader for the {@code person_team} table.
 */
public class PersonTeamCursorLoader extends AbstractCursorLoader<PersonTeamCursor> {
    /**
     * Default CursorLoader with all the fields in the table read.
     *
     * @param context used by {@link android.support.v4.content.Loader Loader}, cannot be {@code null}.
     * @param databaseSource the database to read items from.
     * @param selection a PersonTeamSelection passed to the dataSource query, may be {@code null} to query all items in the database.
     * @param sortOrder the sorting order for the items read from the database, undefined order if {@code null}.
     */
    public PersonTeamCursorLoader(@NonNull Context context, @NonNull TypedDatabaseSource<?, ?, PersonTeamCursor> databaseSource, @Nullable PersonTeamSelection selection, @Nullable String sortOrder) {
        this(context, databaseSource, PersonTeamColumns.ALL_COLUMNS, selection, sortOrder);
    }

    /**
     * CursorLoader with a custom projection. Reading the {@link PersonTeamCursor} as a {@link PersonTeamModel} may not work if you don't read the mandatory fields.
     *
     * @param context used by {@link android.support.v4.content.Loader Loader}, cannot be {@code null}.
     * @param databaseSource the database to read items from.
     * @param projection custom projection, will use all the fields if set to {@code null}.
     * @param selection a PersonTeamSelection passed to the dataSource query, may be {@code null} to query all items in the database.
     * @param sortOrder the sorting order for the items read from the database, undefined order if {@code null}.
     * @see #PersonTeamCursorLoader(android.content.Context, org.gawst.asyncdb.source.typed.TypedDatabaseSource, PersonTeamSelection, String)
     */
    public PersonTeamCursorLoader(@NonNull Context context, @NonNull TypedDatabaseSource<?, ?, PersonTeamCursor> databaseSource, @Nullable String[] projection, @Nullable PersonTeamSelection selection, @Nullable String sortOrder) {
        super(context, databaseSource, projection == null ? PersonTeamColumns.ALL_COLUMNS : projection, selection == null ? new PersonTeamSelection() : selection, sortOrder);
    }
}
