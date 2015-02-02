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

import android.content.Context;
import android.database.Cursor;
import android.support.annotation.NonNull;

import org.jraf.androidcontentprovidergenerator.sample.provider.SampleSQLiteOpenHelper;
import org.jraf.androidcontentprovidergenerator.sample.provider.base.AbstractSqliteMapDataSource;
import org.jraf.androidcontentprovidergenerator.sample.provider.base.MapDatabaseModelHandler;
import org.jraf.androidcontentprovidergenerator.sample.provider.base.MapDatabaseSerializer;

/**
 * A serial number.
 * <p>A data source to be used with {@link org.gawst.asyncdb.AsynchronousDbHelper AsynchronousDbHelper}.</p>
 * @see SerialNumberMapDatabaseSerializer
 */
public class SerialNumberSqliteMapDataSource extends AbstractSqliteMapDataSource<SerialNumberKey, SerialNumberValue, SerialNumberCursor, SerialNumberSelection> {
    /**
     * Contructor.
     *
     * <p>Uses a {@link org.jraf.androidcontentprovidergenerator.sample.provider.serialnumber.SerialNumberMapDatabaseModelHandler} to read/write data in the database.</p>
     *
     * @param context Context used to get the {@link android.database.sqlite.SQLiteOpenHelper SQLiteOpenHelper} used to access the data
     */
    public SerialNumberSqliteMapDataSource(@NonNull Context context) {
        this(context, SerialNumberMapDatabaseSerializer.INSTANCE);
    }

    /**
     * Contructor.
     *
     * <p>Uses a {@link org.jraf.androidcontentprovidergenerator.sample.provider.serialnumber.SerialNumberMapDatabaseModelHandler} to read/write data in the database.</p>
     *
     * @param context Context used to get the {@link android.database.sqlite.SQLiteOpenHelper SQLiteOpenHelper} used to access the data
     */
    public SerialNumberSqliteMapDataSource(@NonNull Context context, MapDatabaseSerializer<SerialNumberKey, SerialNumberValue, SerialNumberCursor> serializer) {
        this(context, new SerialNumberMapDatabaseModelHandler(serializer));
    }

    /**
     * Contructor.
     *
     * <p>Uses a {@link org.jraf.androidcontentprovidergenerator.sample.provider.serialnumber.SerialNumberMapDatabaseModelHandler} to read/write data in the database.</p>
     *
     * @param context Context used to get the {@link android.database.sqlite.SQLiteOpenHelper SQLiteOpenHelper} used to access the data
     */
    public SerialNumberSqliteMapDataSource(@NonNull Context context, @NonNull MapDatabaseModelHandler<SerialNumberKey, SerialNumberValue, SerialNumberCursor, SerialNumberSelection> databaseModelHandler) {
        super(context, SampleSQLiteOpenHelper.getInstance(context), SerialNumberColumns.TABLE_NAME, SampleSQLiteOpenHelper.DATABASE_FILE_NAME, databaseModelHandler);
    }

    @Override
    public SerialNumberCursor wrapCursor(Cursor cursor) {
        return new SerialNumberCursor(cursor);
    }

    public <MODEL extends SerialNumberKey & SerialNumberValue> Long insert(MODEL value) {
        return insert(value, value);
    }

    public <MODEL extends SerialNumberKey & SerialNumberValue> boolean update(MODEL value) {
        return update(value, value);
    }
}