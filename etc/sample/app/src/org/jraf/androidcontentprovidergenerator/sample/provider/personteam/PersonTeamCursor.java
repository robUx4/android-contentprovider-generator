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

import android.database.Cursor;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

import org.jraf.androidcontentprovidergenerator.sample.provider.base.AbstractCursor;
import org.jraf.androidcontentprovidergenerator.sample.provider.person.*;
import org.jraf.androidcontentprovidergenerator.sample.provider.team.*;
import org.jraf.androidcontentprovidergenerator.sample.provider.company.*;
import org.jraf.androidcontentprovidergenerator.sample.provider.serialnumber.*;
import org.jraf.androidcontentprovidergenerator.sample.provider.serialnumber.*;

/**
 * Cursor wrapper for the {@code person_team} table.
 */
public class PersonTeamCursor extends AbstractCursor implements PersonTeamModel {
    public PersonTeamCursor(Cursor cursor) {
        super(cursor);
    }

    /**
     * Primary key.
     */
    public long getId() {
        return getLongOrNull(PersonTeamColumns._ID);
    }

    /**
     * Get the {@code person_id} value.
     */
    public long getPersonId() {
        return getLongOrNull(PersonTeamColumns.PERSON_ID);
    }

    /**
     * First name of this person. For instance, John.
     * Cannot be {@code null}.
     */
    @NonNull
    public String getPersonFirstName() {
        String res = getStringOrNull(PersonColumns.FIRST_NAME);
        if (res == null)
            throw new NullPointerException("The value of 'first_name' in the database was null, which is not allowed according to the model definition");
        return res;
    }

    /**
     * Last name (a.k.a. Given name) of this person. For instance, Smith.
     * Cannot be {@code null}.
     */
    @NonNull
    public String getPersonLastName() {
        String res = getStringOrNull(PersonColumns.LAST_NAME);
        if (res == null)
            throw new NullPointerException("The value of 'last_name' in the database was null, which is not allowed according to the model definition");
        return res;
    }

    /**
     * Get the {@code age} value.
     */
    public int getPersonAge() {
        return getIntegerOrNull(PersonColumns.AGE);
    }

    /**
     * Get the {@code birth_date} value.
     * Can be {@code null}.
     */
    @Nullable
    public Date getPersonBirthDate() {
        return getDateOrNull(PersonColumns.BIRTH_DATE);
    }

    /**
     * If {@code true}, this person has blue eyes. Otherwise, this person doesn't have blue eyes.
     */
    public boolean getPersonHasBlueEyes() {
        return getBooleanOrNull(PersonColumns.HAS_BLUE_EYES);
    }

    /**
     * Get the {@code height} value.
     * Can be {@code null}.
     */
    @Nullable
    public Float getPersonHeight() {
        return getFloatOrNull(PersonColumns.HEIGHT);
    }

    /**
     * Get the {@code gender} value.
     * Cannot be {@code null}.
     */
    @NonNull
    public Gender getPersonGender() {
        Integer intValue = getIntegerOrNull(PersonColumns.GENDER);
        if (intValue == null)
            throw new NullPointerException("The value of 'gender' in the database was null, which is not allowed according to the model definition");
        return Gender.values()[intValue];
    }

    /**
     * Get the {@code country_code} value.
     * Cannot be {@code null}.
     */
    @NonNull
    public String getPersonCountryCode() {
        String res = getStringOrNull(PersonColumns.COUNTRY_CODE);
        if (res == null)
            throw new NullPointerException("The value of 'country_code' in the database was null, which is not allowed according to the model definition");
        return res;
    }

    /**
     * Get the {@code team_id} value.
     */
    public long getTeamId() {
        return getLongOrNull(PersonTeamColumns.TEAM_ID);
    }

    /**
     * Get the {@code company_id} value.
     */
    public long getTeamCompanyId() {
        return getLongOrNull(TeamColumns.COMPANY_ID);
    }

    /**
     * The commercial name of this company.
     * Cannot be {@code null}.
     */
    @NonNull
    public String getTeamCompanyName() {
        String res = getStringOrNull(CompanyColumns.NAME);
        if (res == null)
            throw new NullPointerException("The value of 'name' in the database was null, which is not allowed according to the model definition");
        return res;
    }

    /**
     * The full address of this company.
     * Can be {@code null}.
     */
    @Nullable
    public String getTeamCompanyAddress() {
        return getStringOrNull(CompanyColumns.ADDRESS);
    }

    /**
     * The serial number of this company.
     */
    public long getTeamCompanySerialNumberId() {
        return getLongOrNull(CompanyColumns.SERIAL_NUMBER_ID);
    }

    /**
     * Unique id, first part.
     * Cannot be {@code null}.
     */
    @NonNull
    public String getTeamCompanySerialNumberPart0() {
        String res = getStringOrNull(SerialNumberColumns.PART0);
        if (res == null)
            throw new NullPointerException("The value of 'part0' in the database was null, which is not allowed according to the model definition");
        return res;
    }

    /**
     * Unique id, second part.
     * Cannot be {@code null}.
     */
    @NonNull
    public String getTeamCompanySerialNumberPart1() {
        String res = getStringOrNull(SerialNumberColumns.PART1);
        if (res == null)
            throw new NullPointerException("The value of 'part1' in the database was null, which is not allowed according to the model definition");
        return res;
    }

    /**
     * Get the {@code name} value.
     * Cannot be {@code null}.
     */
    @NonNull
    public String getTeamName() {
        String res = getStringOrNull(TeamColumns.NAME);
        if (res == null)
            throw new NullPointerException("The value of 'name' in the database was null, which is not allowed according to the model definition");
        return res;
    }

    /**
     * 2 letter country code where this team operates.
     * Cannot be {@code null}.
     */
    @NonNull
    public String getTeamCountryCode() {
        String res = getStringOrNull(TeamColumns.COUNTRY_CODE);
        if (res == null)
            throw new NullPointerException("The value of 'country_code' in the database was null, which is not allowed according to the model definition");
        return res;
    }

    /**
     * The serial number of this team.
     */
    public long getTeamSerialNumberId() {
        return getLongOrNull(TeamColumns.SERIAL_NUMBER_ID);
    }

    /**
     * Unique id, first part.
     * Cannot be {@code null}.
     */
    @NonNull
    public String getTeamSerialNumberPart0() {
        String res = getStringOrNull(SerialNumberColumns.PART0);
        if (res == null)
            throw new NullPointerException("The value of 'part0' in the database was null, which is not allowed according to the model definition");
        return res;
    }

    /**
     * Unique id, second part.
     * Cannot be {@code null}.
     */
    @NonNull
    public String getTeamSerialNumberPart1() {
        String res = getStringOrNull(SerialNumberColumns.PART1);
        if (res == null)
            throw new NullPointerException("The value of 'part1' in the database was null, which is not allowed according to the model definition");
        return res;
    }
}
