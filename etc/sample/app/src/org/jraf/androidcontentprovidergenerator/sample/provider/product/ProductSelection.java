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

import java.util.Date;

import android.content.ContentResolver;
import android.database.Cursor;
import android.net.Uri;

import org.jraf.androidcontentprovidergenerator.sample.provider.base.AbstractSelection;

/**
 * Selection for the {@code product} table.
 */
public class ProductSelection extends AbstractSelection<ProductSelection> {
    @Override
    public Uri uri() {
        return ProductColumns.CONTENT_URI;
    }

    /**
     * Query the given content resolver using this selection.
     *
     * @param contentResolver The content resolver to query.
     * @param projection A list of which columns to return. Passing null will return all columns, which is inefficient.
     * @param sortOrder How to order the rows, formatted as an SQL ORDER BY clause (excluding the ORDER BY itself). Passing null will use the default sort
     *            order, which may be unordered.
     * @return A {@code ProductCursor} object, which is positioned before the first entry, or null.
     */
    public ProductCursor query(ContentResolver contentResolver, String[] projection, String sortOrder) {
        Cursor cursor = contentResolver.query(uri(), projection, sel(), args(), sortOrder);
        if (cursor == null) return null;
        return new ProductCursor(cursor);
    }

    /**
     * Equivalent of calling {@code query(contentResolver, projection, null}.
     */
    public ProductCursor query(ContentResolver contentResolver, String[] projection) {
        return query(contentResolver, projection, null);
    }

    /**
     * Equivalent of calling {@code query(contentResolver, projection, null, null}.
     */
    public ProductCursor query(ContentResolver contentResolver) {
        return query(contentResolver, null, null);
    }


    public ProductSelection id(long... value) {
        addEquals("product." + ProductColumns._ID, toObjectArray(value));
        return this;
    }


    public ProductSelection name(String... value) {
        addEquals(ProductColumns.NAME, value);
        return this;
    }

    public ProductSelection nameNot(String... value) {
        addNotEquals(ProductColumns.NAME, value);
        return this;
    }

    public ProductSelection nameLike(String... value) {
        addLike(ProductColumns.NAME, value);
        return this;
    }

    public ProductSelection nameContains(String... value) {
        addContains(ProductColumns.NAME, value);
        return this;
    }

    public ProductSelection nameStartsWith(String... value) {
        addStartsWith(ProductColumns.NAME, value);
        return this;
    }

    public ProductSelection nameEndsWith(String... value) {
        addEndsWith(ProductColumns.NAME, value);
        return this;
    }
}
