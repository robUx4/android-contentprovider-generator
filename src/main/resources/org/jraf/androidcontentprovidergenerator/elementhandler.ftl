<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.${entity.packageName};

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

import com.levelup.palabre.provider.base.AbstractElementHandler;

/**
<#if entity.documentation??>
 * ${entity.documentation}
<#else>
 * AsyncDB ElementHandler for the {@code ${entity.nameLowerCase}} table.
 * <p>Uses the _id field from the database to select items</p>
</#if>
 */
public class ${entity.nameCamelCase}ElementHandler extends AbstractElementHandler<${entity.nameCamelCase}Model, ${entity.nameCamelCase}Cursor> {
    public ${entity.nameCamelCase}ElementHandler(${entity.nameCamelCase}Serializer serializer) {
        super(serializer);
    }

    @NonNull
    @Override
    public String getItemSelectClause(@Nullable ${entity.nameCamelCase}Model itemToSelect) {
        ${entity.nameCamelCase}Selection selection = new ${entity.nameCamelCase}Selection();
        if (itemToSelect != null)
            selection.id(0);
        return selection.sel();
    }

    @NonNull
    @Override
    public String[] getItemSelectArgs(@NonNull ${entity.nameCamelCase}Model itemToSelect) {
        return new ${entity.nameCamelCase}Selection().id(itemToSelect.getId()).args();
    }
}