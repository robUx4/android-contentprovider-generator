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
package org.jraf.androidcontentprovidergenerator.sample.provider.team;

import android.content.ContentResolver;
import android.content.Context;
import android.database.Cursor;
import android.support.annotation.NonNull;

import org.jraf.androidcontentprovidergenerator.sample.provider.base.AbstractContentProviderDataSource;
import org.jraf.androidcontentprovidergenerator.sample.provider.base.DatabaseModelHandler;
import org.jraf.androidcontentprovidergenerator.sample.provider.base.DatabaseSerializer;

/**
 * A group of people who work together.
 * <p>A data source to be used with {@link org.gawst.asyncdb.AsynchronousDbHelper AsynchronousDbHelper}.</p>
 * @see TeamDatabaseSerializer
 */
public class TeamContentProviderDataSource extends AbstractContentProviderDataSource<TeamModel, TeamCursor, TeamSelection> {
    /**
     * Contructor.
     * <p>Uses a {@link org.jraf.androidcontentprovidergenerator.sample.provider.team.TeamDatabaseModelHandler} to read/write data in the Content Provider.</p>
     *
     * @param contentResolver ContentResolver used to access the {@link android.content.ContentProvider ContentProvider}
     */
    public TeamContentProviderDataSource(@NonNull ContentResolver contentResolver) {
        this(contentResolver, TeamDatabaseSerializer.INSTANCE);
    }

    /**
     * Contructor.
     * <p>Uses a {@link org.jraf.androidcontentprovidergenerator.sample.provider.team.TeamDatabaseModelHandler} to read/write data in the Content Provider.</p>
     *
     * @param context    Context used to get the {@link android.content.ContentResolver ContentResolver} used to access the {@link android.content.ContentProvider ContentProvider}
     */
    public TeamContentProviderDataSource(@NonNull Context context) {
        this(context, TeamDatabaseSerializer.INSTANCE);
    }

    /**
     * Contructor.
     * <p>Uses a {@link org.jraf.androidcontentprovidergenerator.sample.provider.team.TeamDatabaseModelHandler} to read/write data in the Content Provider.</p>
     *
     * @param contentResolver ContentResolver used to access the {@link android.content.ContentProvider ContentProvider}
     * @param serializer      the serializer that will transform a {@link TeamCursor} to a {@link TeamModel}
     *                        or a {@link TeamModel} into {@code ContentValues}
     */
    public TeamContentProviderDataSource(@NonNull ContentResolver contentResolver, @NonNull DatabaseSerializer<TeamModel, TeamCursor> serializer) {
        this(contentResolver, new TeamDatabaseModelHandler(serializer));
    }

    /**
     * Contructor.
     * <p>Uses a {@link org.jraf.androidcontentprovidergenerator.sample.provider.team.TeamDatabaseModelHandler} to read/write data in the Content Provider.</p>
     *
     * @param context    Context used to get the {@link android.content.ContentResolver ContentResolver} used to access the {@link android.content.ContentProvider ContentProvider}
     * @param serializer the serializer that will transform a {@link TeamCursor} to a {@link TeamModel}
     *                   or a {@link TeamModel} into {@code ContentValues}
     */
    public TeamContentProviderDataSource(@NonNull Context context, @NonNull DatabaseSerializer<TeamModel, TeamCursor> serializer) {
        this(context, new TeamDatabaseModelHandler(serializer));
    }

    /**
     * Contructor.
     *
     * @param contentResolver ContentResolver used to access the {@link android.content.ContentProvider ContentProvider}.
     * @param modelHandler to handle {@link TeamModel} read/write/query in the Content Provider.
     */
    public TeamContentProviderDataSource(@NonNull ContentResolver contentResolver, @NonNull DatabaseModelHandler<TeamModel, TeamCursor, TeamSelection> modelHandler) {
        super(contentResolver, TeamColumns.CONTENT_URI, modelHandler);
    }

    /**
     * Contructor.
     *
     * @param context      Context used to get the {@link android.content.ContentResolver ContentResolver} used to access the {@link android.content.ContentProvider ContentProvider}
     * @param modelHandler to handle {@link TeamModel} read/write/query in the Content Provider.
     */
    public TeamContentProviderDataSource(@NonNull Context context, @NonNull DatabaseModelHandler<TeamModel, TeamCursor, TeamSelection> modelHandler) {
        super(context, TeamColumns.CONTENT_URI, modelHandler);
    }

    @Override
    public TeamCursor wrapCursor(Cursor cursor) {
        return new TeamCursor(cursor);
    }
}