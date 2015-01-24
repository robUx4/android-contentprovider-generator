<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.${entity.packageName};

import android.content.ContentValues;
import android.support.annotation.NonNull;

import ${config.providerJavaPackage}.base.MapDatabaseSerializer;

/**
<#if entity.documentation??>
 * ${entity.documentation}
<#else>
 * Default Map Serializer class for the {@code ${entity.nameLowerCase}} table.
</#if>
 * @see ${entity.nameCamelCase}ContentProviderDataSource#${entity.nameCamelCase}ContentProviderDataSource(android.content.Context, ${config.providerJavaPackage}.base.DatabaseSerializer)
 * @see ${entity.nameCamelCase}ContentProviderDataSource#${entity.nameCamelCase}ContentProviderDataSource(android.content.ContentResolver, ${config.providerJavaPackage}.base.DatabaseSerializer)
 * @see ${entity.nameCamelCase}SqliteDataSource#${entity.nameCamelCase}implements DatabaseSerializer(android.content.Context, ${config.providerJavaPackage}.base.DatabaseSerializer)
 */
public class ${entity.nameCamelCase}MapDatabaseSerializer implements MapDatabaseSerializer<${entity.nameCamelCase}Key, ${entity.nameCamelCase}Value, ${entity.nameCamelCase}Cursor> {
    @NonNull
    @Override
    public ${entity.nameCamelCase}Key getKeyFromCursor(${entity.nameCamelCase}Cursor cursor) {
        return new ${entity.nameCamelCase}KeyImpl.Builder(cursor).build();
    }

    @NonNull
    @Override
    public ${entity.nameCamelCase}Value getValueFromCursor(${entity.nameCamelCase}Cursor cursor) {
        return new ${entity.nameCamelCase}ValueImpl.Builder(cursor).build();
    }

    @NonNull
    @Override
    public ContentValues getContentValuesFromData(@NonNull ${entity.nameCamelCase}Key key, @NonNull ${entity.nameCamelCase}Value value, boolean update) {
        ${entity.nameCamelCase}ContentValues values = new ${entity.nameCamelCase}ContentValues();
    <#list entity.fields as field>
        <#if !field.isId>
        <#if field.isKey>
        if (!update)
            values.put${field.nameCamelCase}(key.get${field.nameCamelCase}());
        <#else>
        values.put${field.nameCamelCase}(value.get${field.nameCamelCase}());
        </#if>
        </#if>
    </#list>
        return values.values();
    }
}