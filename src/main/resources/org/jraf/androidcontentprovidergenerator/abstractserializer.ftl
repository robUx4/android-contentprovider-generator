<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.${entity.packageName};

import android.content.ContentValues;
import android.support.annotation.NonNull;

import ${config.providerJavaPackage}.base.DatabaseSerializer;

/**
<#if entity.documentation??>
 * ${entity.documentation}
<#else>
 * Default Serializer class for the {@code ${entity.nameLowerCase}} table.
</#if>
 * @see ${entity.nameCamelCase}DataSource#${entity.nameCamelCase}DataSource(android.content.Context, ${config.providerJavaPackage}.base.DatabaseSerializer)
 * @see ${entity.nameCamelCase}DataSource#${entity.nameCamelCase}DataSource(android.content.ContentResolver, ${config.providerJavaPackage}.base.DatabaseSerializer)
 */
public class ${entity.nameCamelCase}DatabaseSerializer implements DatabaseSerializer<${entity.nameCamelCase}Model, ${entity.nameCamelCase}Cursor> {
    @NonNull
    @Override
    public ${entity.nameCamelCase}Model getValueFromCursor(${entity.nameCamelCase}Cursor cursor) {
        return new ${entity.nameCamelCase}Impl.Builder(cursor).build();
    }

    @NonNull
    @Override
    public ContentValues getContentValuesFromData(@NonNull ${entity.nameCamelCase}Model data, boolean update) {
        ${entity.nameCamelCase}ContentValues values = new ${entity.nameCamelCase}ContentValues();
    <#list entity.fields as field>
        <#if !field.isId>
        <#if field.isKey>
        if (!update)
            values.put${field.nameCamelCase}(data.get${field.nameCamelCase}());
        <#else>
        values.put${field.nameCamelCase}(data.get${field.nameCamelCase}());
        </#if>
        </#if>
    </#list>
        return values.values();
    }
}