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
package org.jraf.androidcontentprovidergenerator.sample.provider.product;

import android.content.Context;
import android.database.Cursor;
import android.support.annotation.NonNull;

import org.jraf.androidcontentprovidergenerator.sample.provider.SampleSQLiteOpenHelper;
import org.jraf.androidcontentprovidergenerator.sample.provider.base.AbstractSqliteDataSource;
import org.jraf.androidcontentprovidergenerator.sample.provider.base.DatabaseModelHandler;
import org.jraf.androidcontentprovidergenerator.sample.provider.base.DatabaseSerializer;

/**
 * A product that the company sells.
 * <p>A data source to be used with {@link org.gawst.asyncdb.AsynchronousDbHelper AsynchronousDbHelper}.</p>
 * @see ProductDatabaseSerializer
 */
public class ProductSqliteDataSource extends AbstractSqliteDataSource<ProductModel, ProductCursor, ProductSelection> {
    /**
     * Contructor.
     *
     * <p>Uses a {@link org.jraf.androidcontentprovidergenerator.sample.provider.product.ProductDatabaseModelHandler} to read/write data in the database.</p>
     *
     * @param context Context used to get the {@link android.database.sqlite.SQLiteOpenHelper SQLiteOpenHelper} used to access the data
     */
    public ProductSqliteDataSource(@NonNull Context context) {
        this(context, ProductDatabaseSerializer.INSTANCE);
    }

    /**
     * Contructor.
     *
     * <p>Uses a {@link org.jraf.androidcontentprovidergenerator.sample.provider.product.ProductDatabaseModelHandler} to read/write data in the database.</p>
     *
     * @param context Context used to get the {@link android.database.sqlite.SQLiteOpenHelper SQLiteOpenHelper} used to access the data
     */
    public ProductSqliteDataSource(@NonNull Context context, DatabaseSerializer<ProductModel, ProductCursor> serializer) {
        this(context, new ProductDatabaseModelHandler(serializer));
    }

    /**
     * Contructor.
     *
     * <p>Uses a {@link org.jraf.androidcontentprovidergenerator.sample.provider.product.ProductDatabaseModelHandler} to read/write data in the database.</p>
     *
     * @param context Context used to get the {@link android.database.sqlite.SQLiteOpenHelper SQLiteOpenHelper} used to access the data
     */
    public ProductSqliteDataSource(@NonNull Context context, @NonNull DatabaseModelHandler<ProductModel, ProductCursor, ProductSelection> databaseModelHandler) {
        super(context, SampleSQLiteOpenHelper.getInstance(context), ProductColumns.TABLE_NAME, SampleSQLiteOpenHelper.DATABASE_FILE_NAME, databaseModelHandler);
    }

    @Override
    public ProductCursor wrapCursor(Cursor cursor) {
        return new ProductCursor(cursor);
    }
}