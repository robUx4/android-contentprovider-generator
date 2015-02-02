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

/**
 * A product that the company sells.
 *
 * @see ProductKeyImpl.Builder
 */
public class ProductKeyImpl implements ProductKey {
    public static class Builder implements ProductKey {
        private long productId;

        public Builder() {
        }

        /**
         * Construct a copy of the specified {@link ProductModel}
         */
        public Builder(ProductModel copy) {
            this.productId = copy.getProductId();
        }

        public Builder setProductId(long productId) {
            this.productId = productId;
            return this;
        }

        @Override
        public long getProductId() {
            return productId;
        }

        public ProductKeyImpl build() {
            return new ProductKeyImpl(this);
        }
    }

    private final long productId;

    protected ProductKeyImpl(Builder builder) {
        this.productId = builder.productId;
    }

    /**
     * Get the {@code product_id} value.
     */
    @Override
    public long getProductId() {
        return productId;
    }

    @Override
    public boolean equals(Object o) {
        if (o==this) return true;
        if (!(o instanceof ProductKey)) return false;
        return
            productId == ((ProductKey) o).getProductId();
    }

    @Override
    public int hashCode() {
        int result = 17;
        result = 31 * result + (int) (productId ^ (productId >>> 32));
        return result;
    }
}
