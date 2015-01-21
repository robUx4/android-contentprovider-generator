<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.${entity.packageName};

import android.content.ContentValues;
import android.support.annotation.NonNull;

/**
<#if entity.documentation??>
 * ${entity.documentation}
<#else>
 * Base Serializer class for the {@code ${entity.nameLowerCase}} table.
</#if>
 */
public abstract class Abstract${entity.nameCamelCase}Serializer implements ${entity.nameCamelCase}Serializer {
    @NonNull
    @Override
    public ContentValues getContentValuesFromData(@NonNull ${entity.nameCamelCase}Model data) {
        ${entity.nameCamelCase}ContentValues values = new ${entity.nameCamelCase}ContentValues();
    <#list entity.fields as field>
        <#if !field.isId>
        values.put${field.nameCamelCase}(data.get${field.nameCamelCase}());
        </#if>
    </#list>
        return values.values();
    }
}