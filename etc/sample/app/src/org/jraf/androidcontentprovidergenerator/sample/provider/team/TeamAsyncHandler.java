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

import android.content.ContentValues;
import android.net.Uri;

import org.gawst.asyncdb.AsynchronousDbHelper;
import org.gawst.asyncdb.source.typed.TypedDatabaseSource;
import org.gawst.asyncdb.typed.TypedAsyncDatabaseHandler;

/**
 * Helper class to post read/write tasks for the {@code team} table.
 */
public class TeamAsyncHandler extends TypedAsyncDatabaseHandler<TeamModel, TeamCursor, Long, Uri> {
    /**
     * Constructor.
     *
     * @param asynchronousDbHelper
     */
    public TeamAsyncHandler(AsynchronousDbHelper<TeamModel, Long> asynchronousDbHelper) {
        super(asynchronousDbHelper, (TypedDatabaseSource<Long, Uri, TeamCursor>) asynchronousDbHelper.getDataSource());
    }

    public void startUpdate(int token, Object cookie, TeamModel itemUpdate) {
        TeamSelection selection = new TeamSelection(itemUpdate);
        startUpdate(token, cookie, itemUpdate, selection.sel(), selection.args());
    }

    public void startUpdate(int token, Object cookie, TeamModel itemUpdate, TeamContentValues values) {
        final TeamSelection selection = new TeamSelection(itemUpdate);
        final ContentValues updateValues = values.values();
        startRunnable(token, cookie, new Runnable() {
            @Override
            public void run() {
                dataSource.update(updateValues, selection.sel(), selection.args());
            }
        });
    }
}
