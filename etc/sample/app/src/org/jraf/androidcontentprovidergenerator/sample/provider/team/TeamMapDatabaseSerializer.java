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

import org.gawst.asyncdb.InvalidDbEntry;

import android.content.ContentValues;
import android.support.annotation.NonNull;

import org.jraf.androidcontentprovidergenerator.sample.provider.base.MapDatabaseSerializer;

/**
 * A group of people who work together.
 * @see TeamSqliteMapDataSource#TeamSqliteMapDataSource(android.content.Context, org.jraf.androidcontentprovidergenerator.sample.provider.base.MapDatabaseSerializer)
 */
public final class TeamMapDatabaseSerializer implements MapDatabaseSerializer<TeamKey, TeamValue, TeamCursor> {
    public static final TeamMapDatabaseSerializer INSTANCE = new TeamMapDatabaseSerializer();

    @NonNull
    @Override
    public TeamKey getKeyFromCursor(TeamCursor cursor) throws InvalidDbEntry {
        return new TeamKeyImpl.Builder(cursor).build();
    }

    @NonNull
    @Override
    public TeamValue getValueFromCursor(TeamCursor cursor) {
        return new TeamValueImpl.Builder(cursor).build();
    }

    @NonNull
    @Override
    public ContentValues getContentValuesFromData(@NonNull TeamKey key, @NonNull TeamValue value, boolean update) {
        TeamContentValues values = new TeamContentValues(key, value, update);
        return values.values();
    }
}