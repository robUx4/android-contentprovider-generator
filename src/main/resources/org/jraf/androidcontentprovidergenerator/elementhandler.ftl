<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.${entity.packageName};

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

import ${config.providerJavaPackage}.base.AbstractElementHandler;

/**
<#if entity.documentation??>
 * ${entity.documentation}
<#else>
 * AsyncDB ElementHandler for the {@code ${entity.nameLowerCase}} table.
 * <p>Uses the _id field from the database to select items</p>
</#if>
 */
public class ${entity.nameCamelCase}ElementHandler extends AbstractElementHandler<${entity.nameCamelCase}Model, ${entity.nameCamelCase}Cursor, ${entity.nameCamelCase}Selection> {
    public ${entity.nameCamelCase}ElementHandler(${entity.nameCamelCase}Serializer serializer) {
        super(serializer);
    }

    @Override
    protected ${entity.nameCamelCase}Selection getItemSelection(@NonNull ${entity.nameCamelCase}Model itemToSelect) {
        return new ${entity.nameCamelCase}Selection().id(itemToSelect.getId());
    }
}