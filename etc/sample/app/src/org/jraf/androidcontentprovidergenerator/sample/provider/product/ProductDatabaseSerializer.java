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

import org.gawst.asyncdb.InvalidDbEntry;

import android.content.ContentValues;
import android.support.annotation.NonNull;

import org.jraf.androidcontentprovidergenerator.sample.provider.base.DatabaseSerializer;

/**
 * A product that the company sells.
 * @see ProductContentProviderDataSource#ProductContentProviderDataSource(android.content.Context, org.jraf.androidcontentprovidergenerator.sample.provider.base.DatabaseSerializer)
 * @see ProductContentProviderDataSource#ProductContentProviderDataSource(android.content.ContentResolver, org.jraf.androidcontentprovidergenerator.sample.provider.base.DatabaseSerializer)
 * @see ProductSqliteDataSource#ProductSqliteDataSource implements DatabaseSerializer(android.content.Context, org.jraf.androidcontentprovidergenerator.sample.provider.base.DatabaseSerializer)
 */
public final class ProductDatabaseSerializer implements DatabaseSerializer<ProductModel, ProductCursor> {
    public static final ProductDatabaseSerializer INSTANCE = new ProductDatabaseSerializer();

    @NonNull
    @Override
    public ProductModel getValueFromCursor(ProductCursor cursor) throws InvalidDbEntry {
        return new ProductImpl.Builder(cursor).build();
    }

    @NonNull
    @Override
    public ContentValues getContentValuesFromData(@NonNull ProductModel data, boolean update) {
        ProductContentValues values = new ProductContentValues(data, update);
        return values.values();
    }
}