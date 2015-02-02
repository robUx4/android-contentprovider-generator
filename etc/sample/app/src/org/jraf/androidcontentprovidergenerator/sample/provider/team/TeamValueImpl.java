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

import java.util.Date;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

/**
 * A group of people who work together.
 *
 * @see TeamValueImpl.Builder
 */
public class TeamValueImpl implements TeamValue {
    public static class Builder implements TeamValue {
        private long companyId;
        private String name;
        private String countryCode;
        private long serialNumberId;

        public Builder() {
        }

        /**
         * Construct a copy of the specified {@link TeamValue}
         */
        public Builder(TeamValue copy) {
            this.companyId = copy.getCompanyId();
            this.name = copy.getName();
            this.countryCode = copy.getCountryCode();
            this.serialNumberId = copy.getSerialNumberId();
        }

        public Builder setCompanyId(long companyId) {
            this.companyId = companyId;
            return this;
        }

        @Override
        public long getCompanyId() {
            return companyId;
        }

        public Builder setName(@NonNull String name) {
            this.name = name;
            return this;
        }

        @NonNull
        @Override
        public String getName() {
            return name;
        }

        public Builder setCountryCode(@NonNull String countryCode) {
            this.countryCode = countryCode;
            return this;
        }

        @NonNull
        @Override
        public String getCountryCode() {
            return countryCode;
        }

        public Builder setSerialNumberId(long serialNumberId) {
            this.serialNumberId = serialNumberId;
            return this;
        }

        @Override
        public long getSerialNumberId() {
            return serialNumberId;
        }

        public TeamValueImpl build() {
            return new TeamValueImpl(this);
        }
    }

    private final long companyId;
    private final String name;
    private final String countryCode;
    private final long serialNumberId;

    protected TeamValueImpl(Builder builder) {
        this.companyId = builder.companyId;
        this.name = builder.name;
        this.countryCode = builder.countryCode;
        this.serialNumberId = builder.serialNumberId;
    }

    /**
     * Get the {@code company_id} value.
     */
    @Override
    public long getCompanyId() {
        return companyId;
    }

    /**
     * Get the {@code name} value.
     * Cannot be {@code null}.
     */
    @NonNull
    @Override
    public String getName() {
        return name;
    }

    /**
     * 2 letter country code where this team operates.
     * Cannot be {@code null}.
     */
    @NonNull
    @Override
    public String getCountryCode() {
        return countryCode;
    }

    /**
     * The serial number of this team.
     */
    @Override
    public long getSerialNumberId() {
        return serialNumberId;
    }
}
