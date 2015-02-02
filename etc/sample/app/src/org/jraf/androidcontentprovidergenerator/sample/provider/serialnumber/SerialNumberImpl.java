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
package org.jraf.androidcontentprovidergenerator.sample.provider.serialnumber;

import java.util.Date;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

/**
 * A serial number.
 *
 * @see SerialNumberImpl.Builder
 */
public class SerialNumberImpl extends SerialNumberKeyImpl implements SerialNumberModel {
    public static class Builder extends SerialNumberKeyImpl.Builder implements SerialNumberModel {
        private String part0;
        private String part1;

        public Builder() {
        }

        /**
         * Construct a copy of the specified {@link SerialNumberModel}
         */
        public Builder(SerialNumberModel copy) {
            super(copy);
            this.part0 = copy.getPart0();
            this.part1 = copy.getPart1();
        }

        public Builder setPart0(@NonNull String part0) {
            this.part0 = part0;
            return this;
        }

        @NonNull
        @Override
        public String getPart0() {
            return part0;
        }

        public Builder setPart1(@NonNull String part1) {
            this.part1 = part1;
            return this;
        }

        @NonNull
        @Override
        public String getPart1() {
            return part1;
        }

        public SerialNumberImpl build() {
            return new SerialNumberImpl(this);
        }
    }

    private final String part0;
    private final String part1;

    protected SerialNumberImpl(Builder builder) {
        super(builder);
        this.part0 = builder.part0;
        this.part1 = builder.part1;
    }

    /**
     * Unique id, first part.
     * Cannot be {@code null}.
     */
    @NonNull
    @Override
    public String getPart0() {
        return part0;
    }

    /**
     * Unique id, second part.
     * Cannot be {@code null}.
     */
    @NonNull
    @Override
    public String getPart1() {
        return part1;
    }
}
