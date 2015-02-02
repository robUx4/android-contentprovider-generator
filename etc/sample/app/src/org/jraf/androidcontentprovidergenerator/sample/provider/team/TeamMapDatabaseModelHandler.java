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

import android.support.annotation.NonNull;

import org.jraf.androidcontentprovidergenerator.sample.provider.base.MapDatabaseModelHandler;
import org.jraf.androidcontentprovidergenerator.sample.provider.base.MapDatabaseSerializer;

/**
 * A group of people who work together.
 * <p>Used to read/write Map elements with {@link TeamKey}/{@link TeamValue} into a database
 * and select items using a {@link org.jraf.androidcontentprovidergenerator.sample.provider.team.TeamSelection}</p>
 */
public class TeamMapDatabaseModelHandler extends MapDatabaseModelHandler<TeamKey, TeamValue, TeamCursor, TeamSelection> {
    /**
     * Default Constructor.
     */
    public TeamMapDatabaseModelHandler() {
        this(TeamMapDatabaseSerializer.INSTANCE);
    }

    /**
     * Constructor.
     *
     * @param serializer transforms a {@link TeamCursor} to a {@link TeamModel}
     *                   or a {@link TeamModel} into {@code ContentValues}
     * @see TeamMapDatabaseSerializer
     */
    public TeamMapDatabaseModelHandler(@NonNull MapDatabaseSerializer<TeamKey, TeamValue, TeamCursor> serializer) {
        super(serializer);
    }

    @Override
    protected TeamSelection getItemSelection(@NonNull TeamKey key) {
        return new TeamSelection(key);
    }
}