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

import android.content.ContentResolver;
import android.content.Context;
import android.database.Cursor;
import android.support.annotation.NonNull;

import org.jraf.androidcontentprovidergenerator.sample.provider.base.AbstractContentProviderDataSource;
import org.jraf.androidcontentprovidergenerator.sample.provider.base.DatabaseModelHandler;
import org.jraf.androidcontentprovidergenerator.sample.provider.base.DatabaseSerializer;

/**
 * A product that the company sells.
 * <p>A data source to be used with {@link org.gawst.asyncdb.AsynchronousDbHelper AsynchronousDbHelper}.</p>
 * @see ProductDatabaseSerializer
 */
public class ProductContentProviderDataSource extends AbstractContentProviderDataSource<ProductModel, ProductCursor, ProductSelection> {
    /**
     * Contructor.
     * <p>Uses a {@link org.jraf.androidcontentprovidergenerator.sample.provider.product.ProductDatabaseModelHandler} to read/write data in the Content Provider.</p>
     *
     * @param contentResolver ContentResolver used to access the {@link android.content.ContentProvider ContentProvider}
     */
    public ProductContentProviderDataSource(@NonNull ContentResolver contentResolver) {
        this(contentResolver, ProductDatabaseSerializer.INSTANCE);
    }

    /**
     * Contructor.
     * <p>Uses a {@link org.jraf.androidcontentprovidergenerator.sample.provider.product.ProductDatabaseModelHandler} to read/write data in the Content Provider.</p>
     *
     * @param context    Context used to get the {@link android.content.ContentResolver ContentResolver} used to access the {@link android.content.ContentProvider ContentProvider}
     */
    public ProductContentProviderDataSource(@NonNull Context context) {
        this(context, ProductDatabaseSerializer.INSTANCE);
    }

    /**
     * Contructor.
     * <p>Uses a {@link org.jraf.androidcontentprovidergenerator.sample.provider.product.ProductDatabaseModelHandler} to read/write data in the Content Provider.</p>
     *
     * @param contentResolver ContentResolver used to access the {@link android.content.ContentProvider ContentProvider}
     * @param serializer      the serializer that will transform a {@link ProductCursor} to a {@link ProductModel}
     *                        or a {@link ProductModel} into {@code ContentValues}
     */
    public ProductContentProviderDataSource(@NonNull ContentResolver contentResolver, @NonNull DatabaseSerializer<ProductModel, ProductCursor> serializer) {
        this(contentResolver, new ProductDatabaseModelHandler(serializer));
    }

    /**
     * Contructor.
     * <p>Uses a {@link org.jraf.androidcontentprovidergenerator.sample.provider.product.ProductDatabaseModelHandler} to read/write data in the Content Provider.</p>
     *
     * @param context    Context used to get the {@link android.content.ContentResolver ContentResolver} used to access the {@link android.content.ContentProvider ContentProvider}
     * @param serializer the serializer that will transform a {@link ProductCursor} to a {@link ProductModel}
     *                   or a {@link ProductModel} into {@code ContentValues}
     */
    public ProductContentProviderDataSource(@NonNull Context context, @NonNull DatabaseSerializer<ProductModel, ProductCursor> serializer) {
        this(context, new ProductDatabaseModelHandler(serializer));
    }

    /**
     * Contructor.
     *
     * @param contentResolver ContentResolver used to access the {@link android.content.ContentProvider ContentProvider}.
     * @param modelHandler to handle {@link ProductModel} read/write/query in the Content Provider.
     */
    public ProductContentProviderDataSource(@NonNull ContentResolver contentResolver, @NonNull DatabaseModelHandler<ProductModel, ProductCursor, ProductSelection> modelHandler) {
        super(contentResolver, ProductColumns.CONTENT_URI, modelHandler);
    }

    /**
     * Contructor.
     *
     * @param context      Context used to get the {@link android.content.ContentResolver ContentResolver} used to access the {@link android.content.ContentProvider ContentProvider}
     * @param modelHandler to handle {@link ProductModel} read/write/query in the Content Provider.
     */
    public ProductContentProviderDataSource(@NonNull Context context, @NonNull DatabaseModelHandler<ProductModel, ProductCursor, ProductSelection> modelHandler) {
        super(context, ProductColumns.CONTENT_URI, modelHandler);
    }

    @Override
    public ProductCursor wrapCursor(Cursor cursor) {
        return new ProductCursor(cursor);
    }
}