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
package org.jraf.androidcontentprovidergenerator.sample.provider.person;

import android.support.annotation.NonNull;

import org.jraf.androidcontentprovidergenerator.sample.provider.base.DatabaseModelHandler;
import org.jraf.androidcontentprovidergenerator.sample.provider.base.DatabaseSerializer;

/**
 * A human being which is part of a team.
 * <p>Used to read/write {@link PersonModel} into a database
 * and select items using a {@link org.jraf.androidcontentprovidergenerator.sample.provider.person.PersonSelection}</p>
 */
public class PersonDatabaseModelHandler extends DatabaseModelHandler<PersonModel, PersonCursor, PersonSelection> {
    /**
     * Default Constructor.
     */
    public PersonDatabaseModelHandler() {
        this(PersonDatabaseSerializer.INSTANCE);
    }

    /**
     * Constructor.
     *
     * @param serializer transforms a {@link PersonCursor} to a {@link PersonModel}
     *                   or a {@link PersonModel} into {@code ContentValues}
     * @see PersonDatabaseSerializer
     */
    public PersonDatabaseModelHandler(DatabaseSerializer<PersonModel, PersonCursor> serializer) {
        super(serializer);
    }

    @Override
    protected PersonSelection getItemSelection(@NonNull PersonModel itemToSelect) {
        return new PersonSelection(itemToSelect);
    }
}