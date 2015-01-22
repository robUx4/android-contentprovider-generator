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
 * Abstract Serializer class for the {@code ${entity.nameLowerCase}} table.
</#if>
 * <p>You need to implement {@link #getValueFromCursor(com.levelup.touiteur.base.AbstractCursor) getValueFromCursor(${entity.nameCamelCase}Cursor)}
 * to turn a {@code Cursor} into your model object(s).</p>
 * <p>Use this class to build a fully working {@link ${config.providerJavaPackage}.${entity.packageName}.${entity.nameCamelCase}DataSource}.</p>
 */
public abstract class Abstract${entity.nameCamelCase}DatabaseSerializer implements DatabaseSerializer<${entity.nameCamelCase}Model, ${entity.nameCamelCase}Cursor> {
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