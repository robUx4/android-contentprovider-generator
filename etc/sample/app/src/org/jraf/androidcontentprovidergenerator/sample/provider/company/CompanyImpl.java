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

import java.util.Date;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

/**
 * A commercial business.
 *
 * @see CompanyImpl.Builder
 */
public class CompanyImpl extends CompanyKeyImpl implements CompanyModel {
    public static class Builder extends CompanyKeyImpl.Builder implements CompanyModel {
        private String name;
        private String address;
        private long serialNumberId;

        public Builder() {
        }

        /**
         * Construct a copy of the specified {@link CompanyModel}
         */
        public Builder(CompanyModel copy) {
            super(copy);
            this.name = copy.getName();
            this.address = copy.getAddress();
            this.serialNumberId = copy.getSerialNumberId();
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

        public Builder setAddress(@Nullable String address) {
            this.address = address;
            return this;
        }

        @Nullable
        @Override
        public String getAddress() {
            return address;
        }

        public Builder setSerialNumberId(long serialNumberId) {
            this.serialNumberId = serialNumberId;
            return this;
        }

        @Override
        public long getSerialNumberId() {
            return serialNumberId;
        }

        public CompanyImpl build() {
            return new CompanyImpl(this);
        }
    }

    private final String name;
    private final String address;
    private final long serialNumberId;

    protected CompanyImpl(Builder builder) {
        super(builder);
        this.name = builder.name;
        this.address = builder.address;
        this.serialNumberId = builder.serialNumberId;
    }

    /**
     * The commercial name of this company.
     * Cannot be {@code null}.
     */
    @NonNull
    @Override
    public String getName() {
        return name;
    }

    /**
     * The full address of this company.
     * Can be {@code null}.
     */
    @Nullable
    @Override
    public String getAddress() {
        return address;
    }

    /**
     * The serial number of this company.
     */
    @Override
    public long getSerialNumberId() {
        return serialNumberId;
    }
}
