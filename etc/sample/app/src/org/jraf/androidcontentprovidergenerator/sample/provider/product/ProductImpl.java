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

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

/**
 * A product that the company sells.
 *
 * @see ProductImpl.Builder
 */
public class ProductImpl extends ProductKeyImpl implements ProductModel {
    public static class Builder extends ProductKeyImpl.Builder implements ProductModel {
        private String name;

        public Builder() {
        }

        /**
         * Construct a copy of the specified {@link ProductModel}
         */
        public Builder(ProductModel copy) {
            super(copy);
            this.name = copy.getName();
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

        public ProductImpl build() {
            return new ProductImpl(this);
        }
    }

    private final String name;

    protected ProductImpl(Builder builder) {
        super(builder);
        this.name = builder.name;
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
}
