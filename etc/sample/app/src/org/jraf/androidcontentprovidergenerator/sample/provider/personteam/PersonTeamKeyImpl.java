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

import java.util.Date;

import android.support.annotation.NonNull;

/**
 * Entity joining people and teams.  A team contains several people, and a person can belong to several teams.
 *
 * @see PersonTeamKeyImpl.Builder
 */
public class PersonTeamKeyImpl implements PersonTeamKey {
    public static class Builder implements PersonTeamKey {
        private long id;

        public Builder() {
        }

        /**
         * Construct a copy of the specified {@link PersonTeamModel}
         */
        public Builder(PersonTeamModel copy) {
            this.id = copy.getId();
        }

        public Builder setId(long id) {
            this.id = id;
            return this;
        }

        @Override
        public long getId() {
            return id;
        }

        public PersonTeamKeyImpl build() {
            return new PersonTeamKeyImpl(this);
        }
    }

    private final long id;

    protected PersonTeamKeyImpl(Builder builder) {
        this.id = builder.id;
    }

    /**
     * Primary key.
     */
    @Override
    public long getId() {
        return id;
    }

    @Override
    public boolean equals(Object o) {
        if (o==this) return true;
        if (!(o instanceof PersonTeamKey)) return false;
        return id == ((PersonTeamKey) o).getId();
    }

    @Override
    public int hashCode() {
        int result = 17;
        result = 31 * result + (int) (id ^ (id >>> 32));
        return result;
    }
}
