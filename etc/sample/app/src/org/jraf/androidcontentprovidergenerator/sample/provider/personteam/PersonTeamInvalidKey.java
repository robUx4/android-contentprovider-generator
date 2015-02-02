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
package org.jraf.androidcontentprovidergenerator.sample.provider.personteam;

import org.gawst.asyncdb.InvalidDbEntry;
import org.gawst.asyncdb.InvalidEntry;

import android.support.annotation.NonNull;

public class PersonTeamInvalidKey extends InvalidDbEntry {
    public PersonTeamInvalidKey(@NonNull PersonTeamKey key)throws InvalidDbEntry {
        super(getInvalidEntry(key));
    }

    private static InvalidEntry getInvalidEntry(@NonNull PersonTeamKey key) throws InvalidDbEntry {
        final PersonTeamSelection invalidSelection = new PersonTeamSelection(key);
        return new InvalidEntry() {
            @Override
            public String[] getSelectArgs() {
                return invalidSelection.args();
            }
        };
    }
}
