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
package org.jraf.androidcontentprovidergenerator.sample.provider.company;

import android.support.annotation.NonNull;

import org.jraf.androidcontentprovidergenerator.sample.provider.base.MapDatabaseModelHandler;
import org.jraf.androidcontentprovidergenerator.sample.provider.base.MapDatabaseSerializer;

/**
 * A commercial business.
 * <p>Used to read/write Map elements with {@link CompanyKey}/{@link CompanyValue} into a database
 * and select items using a {@link org.jraf.androidcontentprovidergenerator.sample.provider.company.CompanySelection}</p>
 */
public class CompanyMapDatabaseModelHandler extends MapDatabaseModelHandler<CompanyKey, CompanyValue, CompanyCursor, CompanySelection> {
    /**
     * Default Constructor.
     */
    public CompanyMapDatabaseModelHandler() {
        this(CompanyMapDatabaseSerializer.INSTANCE);
    }

    /**
     * Constructor.
     *
     * @param serializer transforms a {@link CompanyCursor} to a {@link CompanyModel}
     *                   or a {@link CompanyModel} into {@code ContentValues}
     * @see CompanyMapDatabaseSerializer
     */
    public CompanyMapDatabaseModelHandler(@NonNull MapDatabaseSerializer<CompanyKey, CompanyValue, CompanyCursor> serializer) {
        super(serializer);
    }

    @Override
    protected CompanySelection getItemSelection(@NonNull CompanyKey key) {
        return new CompanySelection(key);
    }
}