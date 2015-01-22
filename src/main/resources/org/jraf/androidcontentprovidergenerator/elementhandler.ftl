<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.${entity.packageName};

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

import ${config.providerJavaPackage}.base.AbstractElementHandler;
import ${config.providerJavaPackage}.base.DatabaseSerializer;

/**
<#if entity.documentation??>
 * ${entity.documentation}
<#else>
 * AsyncDB ElementHandler for the {@code ${entity.nameLowerCase}} table.
 * <p>Uses the _id field from the database to select items</p>
</#if>
 */
public class ${entity.nameCamelCase}ElementHandler extends AbstractElementHandler<${entity.nameCamelCase}Model, ${entity.nameCamelCase}Cursor, ${entity.nameCamelCase}Selection> {
    public ${entity.nameCamelCase}ElementHandler(DatabaseSerializer<${entity.nameCamelCase}Model, ${entity.nameCamelCase}Cursor> serializer) {
        super(serializer);
    }

    @Override
    protected ${entity.nameCamelCase}Selection getItemSelection(@NonNull ${entity.nameCamelCase}Model itemToSelect) {
        return new ${entity.nameCamelCase}Selection()
        <#list entity.getKeys() as key>
        <#if key.isId>
        .id(itemToSelect.getId())
        <#else>
        .<#if key.isForeign>${key.path?uncap_first}${key.nameCamelCase}<#else>${key.nameCamelCaseLowerCase}</#if>(itemToSelect.get<#if key.isForeign>${key.path}</#if>${key.nameCamelCase}())<#if !(key_has_next)>;<#else>.and()</#if>
        </#if>
        </#list>
    }
}