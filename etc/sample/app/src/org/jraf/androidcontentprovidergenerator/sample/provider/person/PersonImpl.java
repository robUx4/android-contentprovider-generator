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

import java.util.Date;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

/**
 * A human being which is part of a team.
 *
 * @see PersonImpl.Builder
 */
public class PersonImpl extends PersonKeyImpl implements PersonModel {
    public static class Builder extends PersonKeyImpl.Builder implements PersonModel {
        private String firstName;
        private String lastName;
        private int age;
        private Date birthDate;
        private boolean hasBlueEyes;
        private Float height;
        private Gender gender;
        private String countryCode;

        public Builder() {
        }

        /**
         * Construct a copy of the specified {@link PersonModel}
         */
        public Builder(PersonModel copy) {
            super(copy);
            this.firstName = copy.getFirstName();
            this.lastName = copy.getLastName();
            this.age = copy.getAge();
            this.birthDate = copy.getBirthDate();
            this.hasBlueEyes = copy.getHasBlueEyes();
            this.height = copy.getHeight();
            this.gender = copy.getGender();
            this.countryCode = copy.getCountryCode();
        }

        public Builder setFirstName(@NonNull String firstName) {
            this.firstName = firstName;
            return this;
        }

        @NonNull
        @Override
        public String getFirstName() {
            return firstName;
        }

        public Builder setLastName(@NonNull String lastName) {
            this.lastName = lastName;
            return this;
        }

        @NonNull
        @Override
        public String getLastName() {
            return lastName;
        }

        public Builder setAge(int age) {
            this.age = age;
            return this;
        }

        @Override
        public int getAge() {
            return age;
        }

        public Builder setBirthDate(@Nullable Date birthDate) {
            this.birthDate = birthDate;
            return this;
        }

        @Nullable
        @Override
        public Date getBirthDate() {
            return birthDate;
        }

        public Builder setHasBlueEyes(boolean hasBlueEyes) {
            this.hasBlueEyes = hasBlueEyes;
            return this;
        }

        @Override
        public boolean getHasBlueEyes() {
            return hasBlueEyes;
        }

        public Builder setHeight(@Nullable Float height) {
            this.height = height;
            return this;
        }

        @Nullable
        @Override
        public Float getHeight() {
            return height;
        }

        public Builder setGender(@NonNull Gender gender) {
            this.gender = gender;
            return this;
        }

        @NonNull
        @Override
        public Gender getGender() {
            return gender;
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

        public PersonImpl build() {
            return new PersonImpl(this);
        }
    }

    private final String firstName;
    private final String lastName;
    private final int age;
    private final Date birthDate;
    private final boolean hasBlueEyes;
    private final Float height;
    private final Gender gender;
    private final String countryCode;

    protected PersonImpl(Builder builder) {
        super(builder);
        this.firstName = builder.firstName;
        this.lastName = builder.lastName;
        this.age = builder.age;
        this.birthDate = builder.birthDate;
        this.hasBlueEyes = builder.hasBlueEyes;
        this.height = builder.height;
        this.gender = builder.gender;
        this.countryCode = builder.countryCode;
    }

    /**
     * First name of this person. For instance, John.
     * Cannot be {@code null}.
     */
    @NonNull
    @Override
    public String getFirstName() {
        return firstName;
    }

    /**
     * Last name (a.k.a. Given name) of this person. For instance, Smith.
     * Cannot be {@code null}.
     */
    @NonNull
    @Override
    public String getLastName() {
        return lastName;
    }

    /**
     * Get the {@code age} value.
     */
    @Override
    public int getAge() {
        return age;
    }

    /**
     * Get the {@code birth_date} value.
     * Can be {@code null}.
     */
    @Nullable
    @Override
    public Date getBirthDate() {
        return birthDate;
    }

    /**
     * If {@code true}, this person has blue eyes. Otherwise, this person doesn't have blue eyes.
     */
    @Override
    public boolean getHasBlueEyes() {
        return hasBlueEyes;
    }

    /**
     * Get the {@code height} value.
     * Can be {@code null}.
     */
    @Nullable
    @Override
    public Float getHeight() {
        return height;
    }

    /**
     * Get the {@code gender} value.
     * Cannot be {@code null}.
     */
    @NonNull
    @Override
    public Gender getGender() {
        return gender;
    }

    /**
     * Get the {@code country_code} value.
     * Cannot be {@code null}.
     */
    @NonNull
    @Override
    public String getCountryCode() {
        return countryCode;
    }
}
