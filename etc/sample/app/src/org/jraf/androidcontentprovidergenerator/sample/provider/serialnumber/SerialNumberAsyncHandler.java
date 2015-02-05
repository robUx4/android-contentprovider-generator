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

import android.content.ContentValues;
import android.net.Uri;

import org.gawst.asyncdb.AsynchronousDbHelper;
import org.gawst.asyncdb.source.typed.TypedDatabaseSource;
import org.gawst.asyncdb.typed.TypedAsyncDatabaseHandler;

/**
 * Helper class to post read/write tasks for the {@code serial_number} table.
 */
public class SerialNumberAsyncHandler extends TypedAsyncDatabaseHandler<SerialNumberModel, SerialNumberCursor, Long, Uri> {
    /**
     * Constructor.
     *
     * @param asynchronousDbHelper asynchronous database.
     */
    public SerialNumberAsyncHandler(AsynchronousDbHelper<SerialNumberModel, Long> asynchronousDbHelper) {
        super(asynchronousDbHelper, (TypedDatabaseSource<Long, Uri, SerialNumberCursor>) asynchronousDbHelper.getDataSource());
    }

    public void startUpdate(int token, Object cookie, SerialNumberModel itemUpdate) {
        SerialNumberSelection selection = new SerialNumberSelection(itemUpdate);
        startUpdate(token, cookie, itemUpdate, selection.sel(), selection.args());
    }

    public void startUpdate(int token, Object cookie, SerialNumberModel itemUpdate, SerialNumberContentValues values) {
        final SerialNumberSelection selection = new SerialNumberSelection(itemUpdate);
        final ContentValues updateValues = values.values();
        startRunnable(token, cookie, new Runnable() {
            @Override
            public void run() {
                dataSource.update(updateValues, selection.sel(), selection.args());
            }
        });
    }
}
