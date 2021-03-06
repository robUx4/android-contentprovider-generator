<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.${entity.packageName};

import java.util.Date;

<#if entity.hasContentProvider>
import android.content.ContentResolver;
</#if>
import android.net.Uri;
<#if config.useAnnotations>
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
</#if>

<#if entity.hasDatabaseSource>
import org.gawst.asyncdb.source.typed.TypedDatabaseSource;
</#if>

import ${config.providerJavaPackage}.base.AbstractContentValues;

/**
 * Content values wrapper for the {@code ${entity.nameLowerCase}} table.
 */
public class ${entity.nameCamelCase}ContentValues extends AbstractContentValues {
    public ${entity.nameCamelCase}ContentValues() {
    }

    <#if entity.keys?has_content>
    public ${entity.nameCamelCase}ContentValues(@NonNull ${entity.nameCamelCase}Model model, boolean update) {
        this(model, model, update);
    }

    public ${entity.nameCamelCase}ContentValues(@NonNull ${entity.nameCamelCase}Key key, @NonNull ${entity.nameCamelCase}Value value, boolean update) {
    <#list entity.fields as field>
        <#if field.nameLowerCase != "_id">
        <#if field.isKey || field.isId>
        if (!update)
            put${field.nameCamelCase}(key.get${field.nameCamelCase}());
        <#else>
        put${field.nameCamelCase}(value.get${field.nameCamelCase}());
        </#if>
        </#if>
    </#list>
    }
    </#if>
<#if !entity.hasContentProvider>

    @Deprecated
    @Override
    public Uri uri() {
        throw new AssertionError("no Content Provider for ${entity.nameCamelCase}");
    }
<#else>

    @Override
    public Uri uri() {
        return ${entity.nameCamelCase}Columns.CONTENT_URI;
    }

    /**
     * Update row(s) using the values stored by this object and the given selection.
     *
     * @param contentResolver The content resolver to use.
     * @param where The selection to use (can be {@code null}).
     */
    public int update(ContentResolver contentResolver, <#if config.useAnnotations>@Nullable</#if> ${entity.nameCamelCase}Selection where) {
        return contentResolver.update(uri(), values(), where == null ? null : where.sel(), where == null ? null : where.args());
    }
</#if>
<#if entity.hasSqliteDatabaseSource>

    /**
     * Inserts a row into a table using the values stored by this object.
     * 
     * @param databaseSource The database/table source to write the values to.
     */
    public Long insert(TypedDatabaseSource<Long, ?, ?> databaseSource) {
        return databaseSource.insert(values());
    }
</#if>
    <#list entity.fields as field>
        <#if field.nameLowerCase != "_id">

    <#if field.documentation??>
    /**
     * ${field.documentation}
     */
    </#if>
    <#if config.useAnnotations && !field.isNullable && !field.type.hasNotNullableJavaType()>
    public ${entity.nameCamelCase}ContentValues put${field.nameCamelCase}(@NonNull ${field.javaTypeSimpleName} value) {
    <#elseif config.useAnnotations && field.isNullable>
    public ${entity.nameCamelCase}ContentValues put${field.nameCamelCase}(@Nullable ${field.javaTypeSimpleName} value) {
    <#else>
    public ${entity.nameCamelCase}ContentValues put${field.nameCamelCase}(${field.javaTypeSimpleName} value) {
    </#if>
            <#if !field.isNullable && !field.type.hasNotNullableJavaType()>
        if (value == null) throw new IllegalArgumentException("${field.nameCamelCaseLowerCase} must not be null");
            </#if>
            <#switch field.type.name()>
            <#case "DATE">
        mContentValues.put(${entity.nameCamelCase}Columns.${field.nameUpperCase}, <#if field.isNullable>value == null ? null : </#if>value.getTime());
            <#break>
            <#case "ENUM">
        mContentValues.put(${entity.nameCamelCase}Columns.${field.nameUpperCase}, <#if field.isNullable>value == null ? null : </#if>value.ordinal());
            <#break>
            <#default>
        mContentValues.put(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
            </#switch>
        return this;
    }

            <#if field.isNullable>
    public ${entity.nameCamelCase}ContentValues put${field.nameCamelCase}Null() {
        mContentValues.putNull(${entity.nameCamelCase}Columns.${field.nameUpperCase});
        return this;
    }
            </#if>
            <#switch field.type.name()>
            <#case "DATE">

    public ${entity.nameCamelCase}ContentValues put${field.nameCamelCase}(<#if field.isNullable><#if config.useAnnotations>@Nullable </#if>Long<#else>long</#if> value) {
        mContentValues.put(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }
            <#break>
            </#switch>
        </#if>
    </#list>
}
