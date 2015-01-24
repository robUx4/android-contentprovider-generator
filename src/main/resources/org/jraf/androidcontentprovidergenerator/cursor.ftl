<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.${entity.packageName};

import java.util.Date;

import android.database.Cursor;
<#if config.useAnnotations>
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
</#if>

import ${config.providerJavaPackage}.base.AbstractCursor;
<#list entity.joinedEntities as joinedEntity>
import ${config.providerJavaPackage}.${joinedEntity.packageName}.*;
</#list>

/**
 * Cursor wrapper for the {@code ${entity.nameLowerCase}} table.
 */
public class ${entity.nameCamelCase}Cursor extends AbstractCursor implements ${entity.nameCamelCase}Model {
    public ${entity.nameCamelCase}Cursor(Cursor cursor) {
        super(cursor);
    }

    public long getId() {
        return getLongOrNull(${entity.nameCamelCase}Columns._ID);
    }
    <#list entity.getFieldsIncludingJoins() as field>
        <#if !field.isId>

    /**
    <#if field.documentation??>
     * ${field.documentation}
    <#else>
     * Get the {@code ${field.nameLowerCase}} value.
    </#if>
        <#if field.isNullable>
     * Can be {@code null}.
        <#else>
            <#if !field.type.hasNotNullableJavaType()>
     * Cannot be {@code null}.
            </#if>
        </#if>
     */
    <#if config.useAnnotations>
        <#if field.isNullable>
    @Nullable
        <#else>
            <#if !field.type.hasNotNullableJavaType()>
    @NonNull
            </#if>
        </#if>
    </#if>
    public ${field.javaTypeSimpleName} get<#if field.isForeign>${field.path}</#if>${field.nameCamelCase}() {
            <#switch field.type.name()>
            <#case "STRING">
                <#if field.isNullable>
        return getStringOrNull(${field.entity.nameCamelCase}Columns.${field.nameUpperCase});
                <#else>
        String res = getStringOrNull(${field.entity.nameCamelCase}Columns.${field.nameUpperCase});
        if (res == null)
            throw new NullPointerException("The value of '${field.nameLowerCase}' in the database was null, which is not allowed according to the model definition");
        return res;
                </#if>
            <#break>
            <#case "INTEGER">
        return getIntegerOrNull(${field.entity.nameCamelCase}Columns.${field.nameUpperCase});
            <#break>
            <#case "LONG">
        return getLongOrNull(${field.entity.nameCamelCase}Columns.${field.nameUpperCase});
            <#break>
            <#case "FLOAT">
        return getFloatOrNull(${field.entity.nameCamelCase}Columns.${field.nameUpperCase});
            <#break>
            <#case "DOUBLE">
        return getDoubleOrNull(${field.entity.nameCamelCase}Columns.${field.nameUpperCase});
            <#break>
            <#case "BOOLEAN">
        return getBooleanOrNull(${field.entity.nameCamelCase}Columns.${field.nameUpperCase});
            <#break>
            <#case "DATE">
                <#if field.isNullable>
        return getDateOrNull(${field.entity.nameCamelCase}Columns.${field.nameUpperCase});
                <#else>
        Date res = getDateOrNull(${field.entity.nameCamelCase}Columns.${field.nameUpperCase});
        if (res == null)
            throw new NullPointerException("The value of '${field.nameLowerCase}' in the database was null, which is not allowed according to the model definition");
        return res;
                </#if>
            <#break>
            <#case "BYTE_ARRAY">
                <#if field.isNullable>
        return getBlobOrNull(${field.entity.nameCamelCase}Columns.${field.nameUpperCase});
                <#else>
        byte[] res = getBlobOrNull(${field.entity.nameCamelCase}Columns.${field.nameUpperCase});
        if (res == null)
            throw new NullPointerException("The value of '${field.nameLowerCase}' in the database was null, which is not allowed according to the model definition");
        return res;
                </#if>
            <#break>
            <#case "ENUM">
        Integer intValue = getIntegerOrNull(${field.entity.nameCamelCase}Columns.${field.nameUpperCase});
        		<#if field.isNullable>
        if (intValue == null) return null;
        		<#else>
        if (intValue == null)
            throw new NullPointerException("The value of '${field.nameLowerCase}' in the database was null, which is not allowed according to the model definition");
        		</#if>
        return ${field.javaTypeSimpleName}.values()[intValue];
            <#break>
            </#switch>
    }
        </#if>
    </#list>
}
